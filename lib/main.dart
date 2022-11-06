// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stein/login.dart';
import 'package:stein/requisicao.dart';
import 'package:stein/venda.dart';

void main() async {
  
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  login(),
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
                title:  Text('  Comandas' , style: GoogleFonts.inter()),
                onTap: (() {
                  mesas.forEach((element) {});
                }),
              ),ListTile(
                title:  Text('  Mesas Ocupadas' , style: GoogleFonts.inter()),
                onTap: (() {
                  mesas.forEach((element) {});
                }),
              ),
              ListTile(
                title:  Text('  Meus Dados',  style: GoogleFonts.inter()),
                onTap: (() {
                  mesas.forEach((element) {});
                }),
              ),
              ListTile(
                title:  Text('  Configurações',  style: GoogleFonts.inter()),
                onTap: (() {
                  mesas.forEach((element) {});
                }),
              ),
              ListTile(
                title:  Text('  Sobre' , style: GoogleFonts.inter()),
                onTap: (() {
                  mesas.forEach((element) {});
                }),
              ),
              ListTile(
                title:  Text('  Ajuda', style: GoogleFonts.inter()),
                onTap: (() {
                  mesas.forEach((element) {});
                }),
              ),
              ListTile(
                title:  Text('  Trocar Funcionário' , style: GoogleFonts.inter()),
                onTap: (() {
                  mesas.forEach((element) {});
                }),
              ),
              ListTile(
                
                title:  Text('  Sair', style: GoogleFonts.inter()),
                onTap: (() {
                 Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>  login(),
      ),
      (route) => false,
    );
                }),
              ),
              
            ],
          ),
        ),
        body:RefreshIndicator(
          
          onRefresh: () async {
            await updateRequest();
            return Future.delayed(const Duration(seconds: 1), () {
                
              setState(()  {
                  updateRequest();
                print('a');
              });
            });
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar.large(
                pinned: true,
                snap: false,
                floating: false,
                title:  Text('STEIN', style: GoogleFonts.josefinSans()),
                actions: [
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(context: context, builder: (context){return SizedBox(
                        height: 300,
                        child: Column(children: [  const SizedBox(height: 75,  child: Center(child: Text('Menu', style: TextStyle(fontSize: 25), textAlign: TextAlign.left,),
                        ),
                        ),
                         const Divider(
                          thickness: 1.5,
                        ), 
                        Expanded(child: ListView(
  children: <Widget>[
    const SizedBox(
        height: 15,
      ),
    InkWell(
      onTap: () {
        
      },
      onLongPress: () {
        
      },
      child: const SizedBox(
        height: 85,
        
        child: Center(child: Text('Comandas', style: TextStyle(fontSize: 20))),
      ),
    ),
    
    InkWell(
      onTap: () {
        
      },
      child: const SizedBox(
        height: 85,
    
        child: Center(child: Text('Sair', style: TextStyle(fontSize: 20),)),
      ),
    ),
    
   
  ],
))
                        ],
                        ),
                      );});
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
                      onTap: (() async{
                        if (texto == 'Ocupada') {
                          final snackBar = SnackBar(
                            content: const Text('Esta mesa está ocupada!'),
                            action: SnackBarAction(
                              label: 'Prosseguir',
                              textColor: Colors.lightBlue,
                              onPressed: () {
                                updateVenda();
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
                                      await updateVenda();
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

Future<void> updateRequest() async {
  await HttpRequest().reqHTTP('Mesa/');
  await HttpRequest().reqHTTP('TiposDeProduto/');
}

Future<void> updateVenda() async {
  await HttpRequest().reqHTTP('TiposDeProduto/');
}
