// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stein/requisicao.dart';

int num = 0;
List filter = [];
var separador = '';

var listaProd = [];

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
      filter.forEach((el1) {
        produtosPerComanda.forEach((el2) {
          if (el1['idProduto'] == el2['id']) {
            el1['quantidade'] = el2['quantidade'];
          }
        });
      });
      if (produtosPerComanda.isNotEmpty) {
        listaProd.addAll(produtosPerComanda);
      }
    });

    print(filter);

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
                    return Expanded(
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
                          setState(() {
                            filter[index]['quantidade']--;
                            if (filter[index]['quantidade'] <= 0) {
                              filter[index]['quantidade'] = 0;
                              listaProd.remove(filter[index]);
                            } else {}
                          });
                        }),
                        onLongPress: (() {
                          setState(() {
                            filter[index]['quantidade'] -= 10;
                            if (filter[index]['quantidade'] < 0) {
                              filter[index]['quantidade'] = 0;
                              listaProd.remove(filter[index]);
                            }
                          });
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
                          setState(() {
                            filter[index]['quantidade']++;
                            if (filter[index]['quantidade'] > 100) {
                              filter[index]['quantidade'] = 100;
                            } else {
                              if (!listaProd.contains(filter[index])) {
                                listaProd.add(filter[index]);
                              }
                            }
                          });
                        },
                        onLongPress: (() {
                          setState(() {
                            filter[index]['quantidade'] += 10;
                            if (filter[index]['quantidade'] > 100) {
                              filter[index]['quantidade'] = 100;
                            } else {
                              if (!listaProd.contains(filter[index])) {
                                listaProd.add(filter[index]);
                              }
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
