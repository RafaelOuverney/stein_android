// ignore_for_file: must_be_immutable, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stein/requisicao.dart';
import 'package:stein/tabs/first_page.dart';
import 'package:stein/venda.dart';
import 'tabs/confirmaComanda.dart';

class Comandas extends StatefulWidget {
  var nummesa = '';
  var valorTotal = '';
  double total = 0;
  var idmesa = '';
  Comandas(
      {super.key,
      required this.nummesa,
      required this.valorTotal,
      required this.idmesa});

  @override
  State<Comandas> createState() => _ComandasState();
}

class _ComandasState extends State<Comandas> {
  @override
  Widget build(BuildContext context) {
    listaProd = [];
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () async {
                  await produtosReq();
                  listaProd = [];
                  filter.addAll(produtosPerComanda);
                  executado = false;
                  metodoo = 'PUT';
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomePage(
                                nmrMesa: widget.nummesa,
                                idmesa: widget.idmesa,
                              )));
                },
                icon: const Icon(Icons.add)),
          )
        ],
        toolbarHeight: 125,
        title: Text(
          'Comanda mesa: ${widget.nummesa}',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
        itemCount: produtosPerComanda.length,
        itemBuilder: ((context, index) {
          return InkWell(
            onTap: (() {
              var produto = produtosPerComanda[index]['quantidade'];
              var valor = double.parse(produtosPerComanda[index]['preco']);
              widget.total = produto * valor;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: AlertDialog(
                          title: Text(
                            '${produtosPerComanda[index]['nome']}',
                            style: const TextStyle(color: Colors.blueAccent),
                          ),
                          content: Text(
                              'Valor total dos produtos: R\$ ${widget.total.toStringAsFixed(2).replaceAll('.', ',')} '),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
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
            }),
            child: ListTile(
              trailing: Text(
                  '${produtosPerComanda[index]['quantidade'].toString()} x R\$${produtosPerComanda[index]['preco'].toString().replaceAll('.', ',')}'),
              title: Text('${produtosPerComanda[index]['nome']}'),
            ),
          );
        }),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey[200],
        child: SizedBox(
          height: 50,
          child: ListTile(
              trailing: Text(widget.valorTotal),
              leading: Text(
                'Valor total da comanda:',
                style: GoogleFonts.inter(),
              )),
        ),
      ),
    );
  }
}
