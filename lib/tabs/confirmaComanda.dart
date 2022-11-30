import 'dart:io';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:stein/main.dart';
import 'package:stein/requisicao.dart';
import 'package:stein/tabs/first_page.dart';

import 'package:stein/venda.dart';

var comentario = '  ';

class ConfirmaComanda extends StatefulWidget {
  var mesa = '';
  var dici = [];
  var idmesa = '';

  ConfirmaComanda({super.key, required this.mesa, required this.idmesa});

  @override
  State<ConfirmaComanda> createState() => _ConfirmaComandaState();
}

class _ConfirmaComandaState extends State<ConfirmaComanda> {
  final formkey = GlobalKey<FormState>();
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
                  content: Form(
                    key: formkey,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          comentario = 'null';
                        }

                        comentario = value;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: null,
                    ),
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
                            await fazPedido(
                              listaProd,
                              widget.idmesa,
                            ).timeout(Duration(seconds: 15));
                          } on SocketException catch (_) {
                            return print('bão?');
                          }

                          await updateRequest();
                          Navigator.pop(context);

                          setState(() {
                            updateRequest();
                          });

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
        child: ListTile(
          leading: Text('Total: R\$ ${somaValorTotal().toStringAsFixed(2)}'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      extendBody: false,
      resizeToAvoidBottomInset: true,
    );
  }
}

somaValorTotal() {
  var valorTotalProd = 0.0;
  listaProd.forEach((element) {
    valorTotalProd += double.parse(element['preco']) * element['quantidade'];
  });
  return valorTotalProd;
}
