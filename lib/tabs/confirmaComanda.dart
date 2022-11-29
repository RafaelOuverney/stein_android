import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:stein/main.dart';
import 'package:stein/requisicao.dart';
import 'package:stein/tabs/first_page.dart';
import 'package:stein/tabs/observacoes.dart';
import 'package:stein/venda.dart';

class ConfirmaComanda extends StatefulWidget {
  var mesa = '';
  var dici = [];
  var idmesa = '';
  var comentario = [];
  ConfirmaComanda({super.key, required this.mesa, required this.idmesa});

  @override
  State<ConfirmaComanda> createState() => _ConfirmaComandaState();
}

class _ConfirmaComandaState extends State<ConfirmaComanda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text('Confirmar pedidos Mesa ${widget.mesa}'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: SafeArea(
          child: ListView.builder(
            itemCount: listaProd.length,
            itemBuilder: ((context, index) {
              return ListTile(
                title: Text('${listaProd[index]['nome']}'),
                trailing: Text(
                    '${listaProd[index]['quantidade']} X R\$ ${listaProd[index]['preco']}'),
              );
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.green[700],
        onPressed: () async {
          // fazPedido(listaProd, widget.idmesa, '2');
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Expanded(
                child: AlertDialog(
                  title: const Text(
                    'Alguma Observação?',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  content: TextFormField(
                    validator: (value) {
                      // comentario = [
                      //   {'comentario : ${value}'}
                      // ];
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: null,
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Voltar',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: Colors.white,
                              ));
                            });

                        // Navigator.pushAndRemoveUntil(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (BuildContext context) =>
                        //         const FirstPage(),
                        //   ),
                        //   (route) => false,
                        // );
                      },
                      child: Text(
                        'Finalizar',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.task_alt,
          size: 25,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey[200],
        shape: const AutomaticNotchedShape(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(0),
              ),
            ),
            RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)))),
        notchMargin: 5,
        child: Container(
          height: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      extendBody: false,
      resizeToAvoidBottomInset: true,
    );
  }
}
