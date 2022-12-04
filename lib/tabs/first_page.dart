// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stein/requisicao.dart';

int num = 0;
List filter = [];
var separador = '';

var listaProd = [];
var executado = false;

class FirstTab extends StatefulWidget {
  var tipoProd = '';

  FirstTab({super.key, required this.tipoProd});

  @override
  State<FirstTab> createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  @override
  Widget build(BuildContext context) {
    separador = widget.tipoProd;

    setState(() {
      filter = [];
      filter.addAll(produtosP);
      filter.retainWhere((element) => element['id'] == separador);
      listaProd = produtosPerComanda;

      for (var c = 0; c < filter.length; c++) {
        for (var i = 0; i < listaIdsProdutosPedidos.length; i++) {
          if (filter[c]['idProduto'] == listaIdsProdutosPedidos[i]) {
            filter[c]['quantidade'] = produtosPerComanda[i]['quantidade'];
          }
        }
      }
    });

    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: filter.length,
          itemBuilder: ((context, index) {
            return InkWell(
              onLongPress: (() {}),
              onTap: (() {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: AlertDialog(
                            title: const Text(
                              'Detalhes do produto',
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                            content: ListTile(
                              title: Text(filter[index]['descrição'] == 'null'
                                  ? 'Sem Descrição'
                                  : '${filter[index]['descrição']}'),
                              subtitle:
                                  Text('Preço: R\$ ${filter[index]['preco']}'),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () async {
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
                title: Text('${filter[index]['nome']}'),
                subtitle: Text('R\$ ${filter[index]['preco']}'),
                leading: SizedBox(
                    width: 100,
                    child: Center(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              '${filter[index]['imagem']}',
                            )))),
                trailing: Container(
                  width: 90,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[800],
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (() {
                          var indexListaIDS = listaIdsProdutosPedidos
                              .indexOf(filter[index]['idProduto']);
                          if (listaIdsProdutosPedidos
                              .contains(filter[index]['idProduto'])) {
                            produtosPerComanda[indexListaIDS]['quantidade']--;
                            if (produtosPerComanda[indexListaIDS]
                                    ['quantidade'] <=
                                0) {
                              produtosPerComanda[indexListaIDS]['quantidade'] =
                                  0;
                            }
                          }
                          setState(() {});
                        }),
                        onLongPress: (() {
                          var indexListaIDS = listaIdsProdutosPedidos
                              .indexOf(filter[index]['idProduto']);

                          setState(() {});
                        }),
                        child: const Icon(
                          CupertinoIcons.minus,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${filter[index]['quantidade']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      InkWell(
                        onTap: () {
                          var indexListaIDS = listaIdsProdutosPedidos
                              .indexOf(filter[index]['idProduto']);
                          if (indexListaIDS == -1) {
                            filter[index]['quantidade']++;
                            produtosPerComanda.add(filter[index]);
                            listaIdsProdutosPedidos
                                .add(filter[index]['idProduto']);
                          } else {
                            produtosPerComanda[indexListaIDS]['quantidade']++;
                          }
                          setState(() {});
                        },
                        onLongPress: (() {
                          setState(() {
                            var indexListaIDS = listaIdsProdutosPedidos
                                .indexOf(filter[index]['idProduto']);
                            if (indexListaIDS == -1) {
                              filter[index]['quantidade'] += 10;
                              produtosPerComanda.add(filter[index]);
                              listaIdsProdutosPedidos
                                  .add(filter[index]['idProduto']);
                            } else {
                              produtosPerComanda[indexListaIDS]['quantidade'] +=
                                  10;
                            }
                          });
                        }),
                        child: const Icon(
                          CupertinoIcons.plus,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
