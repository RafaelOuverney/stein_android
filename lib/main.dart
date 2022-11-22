// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stein/comandas.dart';
import 'package:stein/login.dart';
import 'package:stein/req.dart';
import 'package:stein/requisicao.dart';
import 'package:stein/sobre.dart';
import 'package:stein/venda.dart';

var nominho = '';
var textoChamado = '';
var contemGarcom = '';

void main() async {
  runApp(const Myapp());
  RqState();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  req = preferences.getString('ip');
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.deepPurple),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.arrow_back_ios_new_outlined),
                title: const Text('Voltar'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              UserAccountsDrawerHeader(
                accountName: Text(funcionarioNome),
                accountEmail: Text(funcionarioFuncao),
                currentAccountPicture: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
              ),
              ListTile(
                title: Text('  Comandas', style: GoogleFonts.inter()),
                onTap: (() {
                  mesas.forEach((element) {});
                }),
              ),
              ListTile(
                title: Text('  Mesas Ocupadas', style: GoogleFonts.inter()),
                onTap: (() {
                  mesas.forEach((element) {
                    Navigator.pop(context);
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 500,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 70,
                                child: Center(
                                  child: Text(
                                    'Mesas Ocupadas',
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1.5,
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: mesasOcup.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Comandas(
                                              nummesa:
                                                  mesasOcup[index].toString(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: ListTile(
                                        leading: const Icon(Icons.table_bar),
                                        trailing: const Icon(Icons.arrow_right),
                                        title: Text('Mesa ${mesasOcup[index]}'),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  });
                }),
              ),
              ListTile(
                title: Text('  Meus Dados', style: GoogleFonts.inter()),
                onTap: (() async {
                  await HttpRequest().reqHTTP('Funcionarios/');
                }),
              ),
              ListTile(
                title: Text('  Sobre', style: GoogleFonts.inter()),
                onTap: (() {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Sobre()));
                }),
              ),
              ListTile(
                title: Text('  Trocar Funcionário', style: GoogleFonts.inter()),
                onTap: (() {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const LoginPage(),
                    ),
                    (route) => false,
                  );
                }),
              ),
              ListTile(
                title: Text('  Sair', style: GoogleFonts.inter()),
                onTap: (() {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => Login(),
                    ),
                    (route) => false,
                  );
                }),
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await updateRequest();
            return Future.delayed(const Duration(seconds: 2), () {
              setState(() {
                updateRequest();
              });
            });
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar.large(
                pinned: MediaQuery.of(context).size.width < 500 ? true : false,
                snap: false,
                floating: false,
                expandedHeight: 250,
                title: Text('STEIN', style: GoogleFonts.josefinSans()),
                actions: [
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: 500,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 70,
                                  child: Center(
                                    child: Text(
                                      'Mesas Ocupadas',
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 1.5,
                                    ),
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: mesasOcup.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Comandas(
                                                nummesa:
                                                    mesasOcup[index].toString(),
                                              ),
                                            ),
                                          );
                                        },
                                        child: ListTile(
                                          leading: const Icon(Icons.table_bar),
                                          trailing:
                                              const Icon(Icons.arrow_right),
                                          title: Text(
                                              //garcomChamado.contains
                                              'Mesa ${mesasOcup[index]}  $contemGarcom'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.table_bar_outlined),
                    tooltip: 'Mesas Ocupadas',
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: 300,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 75,
                                    child: Center(
                                      child: Text(
                                        'Menu',
                                        style: TextStyle(fontSize: 25),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1.5,
                                  ),
                                  Expanded(
                                      child: ListView(
                                    children: <Widget>[
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        onLongPress: () {},
                                        child: const SizedBox(
                                          height: 85,
                                          child: Center(
                                              child: Text('Comandas',
                                                  style:
                                                      TextStyle(fontSize: 20))),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Login(),
                                            ),
                                            (route) => false,
                                          );
                                        },
                                        child: const SizedBox(
                                          height: 85,
                                          child: Center(
                                              child: Text(
                                            'Sair',
                                            style: TextStyle(fontSize: 20),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            );
                          });
                    },
                    icon: const Icon(Icons.more_vert_rounded),
                  ),
                ],
              ),
              MediaQuery.of(context).size.width < 500
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        Color? cor;
                        var texto = '';
                        if (mesasOcup.isNotEmpty) {
                          for (var mesa in mesasOcup) {
                            if (garcomChamado.contains(mesas[index])) {
                              cor = Color.fromARGB(255, 241, 238, 21);
                              texto = 'Ocupada';
                              break;
                            }
                            if (mesas[index] == mesa) {
                              cor = Colors.red[400];
                              texto = 'Ocupada';
                              break;
                            } else {
                              cor = Colors.green[400];
                            }
                          }
                        } else {
                          cor = Colors.green[400];
                        }

                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: InkWell(
                            onTap: (() async {
                              if (cor == Color.fromARGB(255, 241, 238, 21) ||
                                  texto == 'ocupada') {
                                textoChamado =
                                    'Responder chamado da mesa ${mesas[index]}';
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Expanded(
                                      child: AlertDialog(
                                        title: const Text(
                                          'Responder Chamado',
                                          style: TextStyle(
                                              color: Colors.blueAccent),
                                        ),
                                        content: Text(textoChamado),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              await respondeChamado(
                                                  mesas[index]);
                                              await updateRequest();
                                              return Future.delayed(
                                                  const Duration(seconds: 1),
                                                  () {
                                                setState(() {
                                                  updateRequest();
                                                });
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: const Text('Ok'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else if (texto == 'Ocupada') {
                                final snackBar = SnackBar(
                                  content:
                                      const Text('Esta mesa está ocupada!'),
                                  action: SnackBarAction(
                                    label: 'Prosseguir',
                                    textColor: Colors.lightBlue,
                                    onPressed: () {
                                      updateComanda();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Comandas(
                                            nummesa: mesas[index].toString(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HomePage(
                                              nmrMesa: mesas[index].toString(),
                                              ocup: texto,
                                            )));
                                await updateVenda();
                              }
                            }),
                            child: SizedBox(
                              height: 125,
                              child: Card(
                                color: cor,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.table_bar),
                                      trailing: const Icon(Icons.arrow_right),
                                      title: Text(
                                        'Mesa ${mesas[index]}',
                                      ),
                                      subtitle: cor == Colors.green[400]
                                          ? const Text('')
                                          : const Text('Valor:'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }, childCount: qtdMesas),
                    )
                  : SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 2.0,
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 1000 ? 4 : 2,
                      ),
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        Color? cor;
                        var texto = '';
                        if (mesasOcup.isNotEmpty) {
                          for (var mesa in mesasOcup) {
                            if (garcomChamado.contains(mesas[index])) {
                              cor = Color.fromARGB(255, 241, 238, 21);
                              texto = 'Ocupada';
                              break;
                            } else if (mesas[index] == mesa) {
                              cor = Colors.red[400];
                              texto = 'Ocupada';
                              break;
                            } else {
                              cor = Colors.green[400];
                            }
                          }
                        } else {
                          cor = Colors.green[400];
                        }
                        return InkWell(
                          onTap: (() async {
                            if (texto == 'Ocupada') {
                              final snackBar = SnackBar(
                                content: const Text('Esta mesa está ocupada!'),
                                action: SnackBarAction(
                                  label: 'Prosseguir',
                                  textColor: Colors.lightBlue,
                                  onPressed: () {
                                    updateComanda();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Comandas(
                                          nummesa: mesas[index].toString(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomePage(
                                            nmrMesa: mesas[index].toString(),
                                            ocup: texto,
                                          )));
                              await updateVenda();
                            }
                          }),
                          child: OverflowBox(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color: cor,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.table_bar),
                                        trailing: const Icon(Icons.arrow_right),
                                        title: Text(
                                          'Mesa ${mesas[index]}',
                                        ),
                                        subtitle: cor == Colors.green[400]
                                            ? const Text('')
                                            : const Text('Valor:'),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        );
                      }, childCount: mesas.length),
                    ),
            ],
          ),
        ));
  }
}

Future<void> updateRequest() async {
  await HttpRequest().reqHTTP('Mesa/');
  await HttpRequest().reqHTTP('TiposDeProduto/');
}

Future<void> updateVenda() async {
  await HttpRequest().reqHTTP('TiposDeProduto/');
}

Future<void> updateFuncionario() async {
  await HttpRequest().reqHTTP('Users/');
}

Future<void> updateComanda() async {
  await HttpRequest().reqHTTP('Comanda/');
}

// Future<void> refreshRequest() async {
//   await HttpRequest().reqHTTP('Mesa/');
//   await Future.delayed(const Duration(seconds: 10));
//   refreshRequest();
// }
