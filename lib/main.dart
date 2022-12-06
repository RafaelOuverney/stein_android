// ignore_for_file: avoid_function_literals_in_foreach_calls, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stein/comandas.dart';
import 'package:stein/login.dart';
import 'package:stein/req.dart';
import 'package:stein/requisicao.dart';
import 'package:stein/sobre.dart';
import 'package:stein/tabs/confirmaComanda.dart';
import 'package:stein/tabs/first_page.dart';
import 'package:stein/venda.dart';

var nominho = '';
var textoChamado = '';
var contemGarcom = '';
var valor = [];
var ind = [];
bool semrede = false;
var respostaChamadoComanda = [];
var abreMesaOcupada = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blueGrey),
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
  void initState() {
    _reload();

    setState(() {
      updateMesas();
    });
    super.initState();
  }

  _reload() async {
    await updateMesas();
    await Future.delayed(const Duration(seconds: 5));
    initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.arrow_back),
                title: const Text('Voltar'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              UserAccountsDrawerHeader(
                accountName: Text(funcionarioNome),
                accountEmail: Text(funcionarioFuncao),
                currentAccountPicture: const CircleAvatar(
                  child: Icon(
                    Icons.person,
                    size: 35,
                  ),
                ),
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
                                      onTap: () async {
                                        abreMesaOcupada = [];
                                        abreMesaOcupada.addAll(listMesas);
                                        abreMesaOcupada.retainWhere((element) =>
                                            element['numero'] ==
                                            mesasOcup[index].toString());
                                        // await requisitaPedidos(
                                        //     abreMesaOcupada[0]['id']);
                                        await pedidosFeitosComandas(
                                            abreMesaOcupada[0]['id']);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    Comandas(
                                                        nummesa:
                                                            abreMesaOcupada[0]
                                                                ['numero'],
                                                        valorTotal:
                                                            'R\$ ${abreMesaOcupada[0]['valorTotal']}',
                                                        idmesa:
                                                            abreMesaOcupada[0]
                                                                ['id'])));
                                      },
                                      child: ListTile(
                                        leading: const Icon(Icons.table_bar),
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
                title: Text('  Sobre', style: GoogleFonts.inter()),
                onTap: (() {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const Sobre()));
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
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: 500,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      child: Center(
                                          child: ListTile(
                                        leading: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.transparent,
                                            )),
                                        trailing: IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(Icons.close)),
                                        title: const Center(
                                            child: Text('Mesas Chamando')),
                                      )),
                                    ),
                                    const Divider(
                                      thickness: 1.5,
                                    ),
                                    Expanded(
                                      child: garcomChamado.isEmpty
                                          ? const Center(
                                              child: Text(
                                                'Sem mesas chamando',
                                                style: TextStyle(fontSize: 17),
                                              ),
                                            )
                                          : ListView.builder(
                                              itemCount: garcomChamado.length,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    respostaChamadoComanda = [];
                                                    respostaChamadoComanda
                                                        .addAll(listMesas);
                                                    respostaChamadoComanda
                                                        .retainWhere((element) =>
                                                            element['numero'] ==
                                                            garcomChamado[index]
                                                                .toString());

                                                    var texto =
                                                        'Responder o chamado da mesa ${garcomChamado[index]}?';
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child:
                                                                  AlertDialog(
                                                                title:
                                                                    const Text(
                                                                  'Responder Chamado',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .blueAccent),
                                                                ),
                                                                content:
                                                                    Text(texto),
                                                                actions: [
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () async {
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return const Center(
                                                                                child: CircularProgressIndicator(
                                                                              color: Colors.white,
                                                                            ));
                                                                          });

                                                                      await respondeChamado(
                                                                          respostaChamadoComanda[0]
                                                                              [
                                                                              'id'],
                                                                          respostaChamadoComanda[0]
                                                                              [
                                                                              'numero']);
                                                                      await updateRequest();
                                                                      setState(
                                                                          () {
                                                                        updateRequest();
                                                                      });

                                                                      Navigator.pop(
                                                                          context);

                                                                      Navigator.pop(
                                                                          context);
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                            'Ok'),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: ListTile(
                                                    leading: const Icon(
                                                        Icons.table_bar),
                                                    trailing: const Icon(
                                                        Icons.arrow_right),
                                                    title: Text(
                                                        //garcomChamado.contains
                                                        'Mesa ${garcomChamado[index]} '),
                                                  ),
                                                );
                                              },
                                            ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      icon: const Icon(Icons.campaign)),
                  IconButton(
                    onPressed: () {
                      ind = [];
                      ind.addAll(listMesas);
                      ind.retainWhere(
                          (element) => element['ocupada'] == 'false');

                      showModalBottomSheet<void>(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: 500,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: ListTile(
                                    leading: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.transparent,
                                        )),
                                    trailing: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.close)),
                                    title: const Center(
                                      child: Text(
                                        'Mesas Livres',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                ),
                                Expanded(
                                  child: ind.isEmpty
                                      ? const Center(
                                          child: Text(
                                            'Todas as mesas estão ocupadas',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        )
                                      : ListView.builder(
                                          itemCount: ind.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () async {
                                                produtosPerComanda.clear();
                                                listaProd.clear();
                                                listaIdsProdutosPedidos.clear();
                                                await produtosReq();

                                                Navigator.pop(context);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            HomePage(
                                                              nmrMesa: ind[
                                                                          index]
                                                                      ['numero']
                                                                  .toString(),
                                                              idmesa: ind[index]
                                                                  ['id'],
                                                            )));
                                              },
                                              child: ListTile(
                                                leading:
                                                    const Icon(Icons.table_bar),
                                                trailing: const Icon(
                                                    Icons.arrow_right),
                                                title: Text(
                                                    //garcomChamado.contains
                                                    'Mesa ${ind[index]['numero'].toString()} '),
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
                    tooltip: 'Mesas Livres',
                  ),
                ],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  Color? cor;
                  var texto = '';
                  if (mesasOcup.isNotEmpty) {
                    for (var mesa in mesasOcup) {
                      if (garcomChamado.contains(mesas[index])) {
                        cor = const Color.fromARGB(255, 255, 196, 0);
                        texto = 'Ocupada';
                        break;
                      }
                      if (mesas[index] == mesa) {
                        cor = const Color.fromARGB(255, 156, 5, 0);
                        texto = 'Ocupada';
                        break;
                      } else {
                        cor = const Color.fromARGB(255, 0, 102, 15);
                      }
                    }
                  } else {
                    cor = const Color.fromARGB(255, 0, 145, 22);
                  }

                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: InkWell(
                      onTap: (() async {
                        if (cor == const Color.fromARGB(255, 255, 196, 0) ||
                            texto == 'ocupada') {
                          textoChamado =
                              'Responder chamado da mesa ${mesas[index]}';
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: AlertDialog(
                                      title: const Text(
                                        'Responder Chamado',
                                        style:
                                            TextStyle(color: Colors.blueAccent),
                                      ),
                                      content: Text(textoChamado),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancelar')),
                                        ElevatedButton(
                                          onPressed: () async {
                                            await respondeChamado(
                                                listMesas[index]['id'],
                                                mesas[index]);
                                            await updateRequest();
                                            return Future.delayed(
                                                const Duration(seconds: 1), () {
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
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (texto == 'Ocupada') {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.white,
                                ));
                              });

                          try {
                            await pedidosFeitosComandas(listMesas[index]['id'])
                                .timeout(const Duration(seconds: 10));
                          } on Exception catch (_) {
                            semrede = true;
                          }
                          if (semrede == true) {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: AlertDialog(
                                        title: Text(
                                          'Erro de conexão',
                                          style:
                                              TextStyle(color: Colors.red[800]),
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
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => Comandas(
                                  idmesa: listMesas[index]['id'],
                                  nummesa:
                                      listMesas[index]['numero'].toString(),
                                  valorTotal:
                                      'R\$ ${listMesas[index]["valorTotal"].toString().replaceAll(".", ",")}',
                                ),
                              ),
                            );
                          }
                        } else {
                          produtosPerComanda = [];
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.white,
                                ));
                              });
                          try {
                            await updateVenda()
                                .timeout(const Duration(seconds: 5));
                            await produtosReq()
                                .timeout(const Duration(seconds: 5));
                            metodoo = 'POST';
                          } on Exception catch (_) {
                            semrede = true;
                          }
                          if (semrede == true) {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: AlertDialog(
                                        title: Text(
                                          'Erro de conexão',
                                          style:
                                              TextStyle(color: Colors.red[800]),
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

                            semrede = false;
                          } else {
                            listaProd = [];
                            listaIdsProdutosPedidos.clear();
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => HomePage(
                                          nmrMesa: listMesas[index]['numero']
                                              .toString(),
                                          idmesa: listMesas[index]['id'],
                                        )));
                          }
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
                                  'Mesa: ${listMesas[index]["numero"]}',
                                  style: TextStyle(
                                      color: cor ==
                                              const Color.fromARGB(
                                                  255, 255, 196, 0)
                                          ? Colors.black
                                          : Colors.white),
                                ),
                                subtitle:
                                    cor == const Color.fromARGB(255, 0, 102, 15)
                                        ? const Text('')
                                        : Text(
                                            'Valor: R\$ ${listMesas[index]["valorTotal"].toString().replaceAll(".", ",")}',
                                            style: TextStyle(
                                                color: cor ==
                                                        const Color.fromARGB(
                                                            255, 255, 196, 0)
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                              ),
                            ],
                          ),
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

Future<void> updateRequest() async {
  await HttpRequest().reqHTTP('Mesa/');
  await HttpRequest().reqHTTP('TiposDeProduto/');
}

Future<void> updateMesas() async {
  await HttpRequest().reqHTTP('Mesa/');
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
