import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stein/requisicao.dart';

int num = 0;

class FirstTab extends StatefulWidget {
  var tipoProd = '';
  FirstTab({super.key, required this.tipoProd});

  @override
  State<FirstTab> createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView.builder(
          itemCount: produtosP.length,
          itemBuilder: ((context, index) {
            return ListTile(
              title: Text('${produtosP[index]['nome']}'),
              subtitle: Text('R\$ ${produtosP[index]['preco']}'),
              leading: SizedBox(
                  width: 75,
                  child: Center(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            '${produtosP[index]['imagem']}',
                          )))),
              trailing: Container(
                width: 90,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (() {
                        setState(() {
                          num--;
                        });
                      }),
                      child: const Icon(
                        CupertinoIcons.minus,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '$num',
                      style: TextStyle(color: Colors.white),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          num++;
                        });
                      },
                      child: Icon(
                        CupertinoIcons.plus,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            );
          })),
    ));
  }
}
