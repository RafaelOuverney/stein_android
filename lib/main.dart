// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:stein/requisicao.dart';
import 'package:stein/venda.dart';

void main() async {
  await updateRequest();
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FirstPage(),
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
              const UserAccountsDrawerHeader(
                accountName: Text('User'),
                accountEmail: Text('Email'),
                currentAccountPicture: CircleAvatar(
                  child: Icon(Icons.person),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Sair'),
                onTap: (() {
                  mesas.forEach((element) {});
                }),
              )
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                updateRequest();
                print('tipo');
              });
            });
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar.large(
                pinned: true,
                snap: false,
                floating: false,
                title: const Text('Stein'),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => HomePage(
                                    nmrMesa: mesas.toString(),
                                    ocup: '',
                                  )));
                    },
                    icon: const Icon(Icons.more_vert_rounded),
                  ),
                ],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  Color? cor;
                  var texto = '';
                  for (var mesa in mesasOcup) {
                    if (mesas[index] == mesa) {
                      cor = Colors.red[400];
                      texto = 'Ocupada';
                      break;
                    } else {
                      cor = Colors.green[400];
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: InkWell(
                      onTap: (() {
                        if (texto == 'Ocupada') {
                          final snackBar = SnackBar(
                            content: const Text('Esta mesa está ocupada!'),
                            action: SnackBarAction(
                              label: 'Proceguir',
                              textColor: Colors.lightBlue,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => HomePage(
                                      nmrMesa: mesas[index].toString(),
                                      ocup: texto,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => HomePage(
                                        nmrMesa: mesas[index].toString(),
                                        ocup: texto,
                                      )));
                        }
                      }),
                      child: Container(
                        color: cor,
                        height: 150,
                        alignment: Alignment.center,
                        child: Text(
                          "Mesa ${mesas[index]}",
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                  );
                }, childCount: qtdMesas),
              )
            ],
          ),
        ));
  }
}

// class GridBuilder extends StatelessWidget {
//   const GridBuilder({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SliverGrid(
//       delegate: SliverChildBuilderDelegate(
//         (context, index) {
//           Color? cor;
//           for (var mesa in mesasOcup) {
//             if (mesas[index] == mesa) {
//               cor = Colors.red[400];
//               break;
//             } else {
//               cor = Colors.green[400];
//             }
//           }
//           return Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(25),
//             ),
//             padding: const EdgeInsets.all(5),
//             child: Container(
//               alignment: Alignment.center,
//               color: cor,
//               child: Text('Mesa ${mesas[index]}'),
//             ),
//           );
//         },
//         childCount: qtdMesas,
//       ),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 10,
//         crossAxisSpacing: 10,
//         childAspectRatio: 2.0,
//       ),
//     );
//   }
// }

Future<void> updateRequest() async {
  await HttpRequest().reqHTTP('Mesa/');
}
