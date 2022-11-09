// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stein/main.dart';
import 'package:stein/requisicao.dart';

class Login extends StatelessWidget {
  bool isLoading = false;
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const SizedBox(
            height: 200,
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
                  await updateRequest();
                  await updateFuncionario();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const LoginPage()));
                },
                label: Text(
                  'Login',
                  style: GoogleFonts.josefinSans(
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                enableFeedback: true,
                hoverElevation: 25,
              ))
        ],
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
                      width: 350,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Usuário'),
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Use seu CPF',
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'Usuario é necessário';
                          } else if (authUsername.contains(value) == false) {
                            return 'Usuário não encontrado';
                          }
                          valida = value;
                          nominho = valida;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 350,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Senha'),
                          prefixIcon: Icon(Icons.lock),
                          hintText: 'Insira sua senha',
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'Senha é necessário';
                          } else if (authUsername.contains(value) == false) {
                            return 'Senha incorreta';
                          } else if (valida != value) {
                            return 'Usuário ou senha Incorretos';
                          }
                          return null;
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
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const FirstPage(),
                              ),
                              (route) => false,
                            );
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
