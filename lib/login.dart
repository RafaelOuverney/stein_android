// ignore_for_file: must_be_immutable, use_build_context_synchronously, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stein/main.dart';
import 'package:stein/req.dart';
import 'package:stein/requisicao.dart';

var senhinha = '';

class Login extends StatelessWidget {
  bool isLoading = false;
  Login({super.key});

  var textinho = Text(
    'Login',
    style: GoogleFonts.josefinSans(
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  );

  var carregamento = const CircularProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.grey[100],
            actions: [
              IconButton(
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: AlertDialog(
                                title: const Text(
                                  'Alerta',
                                  style: TextStyle(color: Colors.red),
                                ),
                                content: const Text(
                                    'Essa é uma janela de configuração de conexão com o servidor, alterações podem ocasionar no não funcionamento da aplicação.'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('CANCELAR'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const Rq()));
                                    },
                                    child: const Text('PROSSEGUIR'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.settings))
            ]),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 125,
                ),
                SizedBox(
                    height: 200,
                    child: Image.asset(
                      'lib/assets/logo.png',
                    )),
                SizedBox(
                  height: 125,
                  child: Text(
                    'STEIN',
                    style: GoogleFonts.josefinSans(
                        textStyle: const TextStyle(fontSize: 25)),
                  ),
                ),
                SizedBox(
                    height: 50,
                    width: 150,
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.grey[800],
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const LoginPage()));
                      },
                      label: isLoading == true ? carregamento : textinho,
                      enableFeedback: true,
                      hoverElevation: 25,
                    ))
              ],
            ),
          ),
        ));
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  var valida = '';
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                        height: 100,
                        child: Image.asset(
                          'lib/assets/logo.png',
                        )),
                    SizedBox(
                      height: 25,
                      child: Text(
                        'LOGIN',
                        style: GoogleFonts.josefinSans(
                            textStyle: const TextStyle(fontSize: 15)),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 100,
                      width: 325,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Usuário'),
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Use seu CPF',
                        ),
                        validator: (value) {
                          // ignore: unnecessary_null_comparison
                          if (value!.isEmpty || value == null) {
                            return 'Usuario é necessário';
                          } else if (value == 'admin') {
                            return 'Usuario Inválido';
                          }
                          nominho = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 325,
                      child: TextFormField(
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            label: const Text('Senha'),
                            prefixIcon: const Icon(Icons.lock),
                            hintText: 'Insira sua senha',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                                icon: Icon(_isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off))),
                        validator: (value) {
                          // ignore: unnecessary_null_comparison
                          if (value!.isEmpty || value == null) {
                            return 'Senha é necessário';
                          }
                          senhinha = value;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: FloatingActionButton.extended(
                        backgroundColor: Colors.grey[800],
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ));
                                });
                            try {
                              await chamaToken(nominho, senhinha)
                                  .timeout(const Duration(seconds: 5));
                            } on Exception catch (_) {
                              semrede = true;
                            }
                            if (semrede == true) {
                              semrede = false;
                              Navigator.pop(context);
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: AlertDialog(
                                          title: Text(
                                            'Erro de conexão',
                                            style: TextStyle(
                                                color: Colors.red[800]),
                                          ),
                                          content: const Text(
                                              'Verifique sua conexão com o servidor e tente novamente'),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Ok',
                                                style: TextStyle(
                                                    color: Colors.grey[800]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              if (tokenzinho != 'invalido') {
                                await HttpRequest().reqHTTP('Funcionarios/');

                                await updateRequest();
                                await updateFuncionario();
                                await produtosReq();

                                Navigator.pop(context);

                                // refreshRequest();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const FirstPage(),
                                  ),
                                  (route) => false,
                                );
                              } else {
                                Navigator.pop(context);

                                showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Expanded(
                                      flex: 1,
                                      child: AlertDialog(
                                        title: const Text(
                                          'Erro',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        content: const Text(
                                            'Usuário ou senha incorretos.'),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Ok'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                          }
                        },
                        label: Text(
                          'Login',
                          style: GoogleFonts.josefinSans(
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        enableFeedback: true,
                        hoverElevation: 25,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
