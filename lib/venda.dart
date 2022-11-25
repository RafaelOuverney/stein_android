// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:stein/requisicao.dart';
import 'package:stein/tabs/first_page.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  String nmrMesa = '';
  String ocup = '';
  String prodId = '';

  HomePage({
    super.key,
    required this.nmrMesa,
    required this.ocup,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tipoTamanho,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  await produtosReq('$tipoTamanho');
                },
                icon: Icon(Icons.shopping_cart)),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.add_task)),
            )
          ],
          toolbarHeight: 100,
          title: Text('Mesa: ${widget.nmrMesa}'),
          titleSpacing: 50,
          centerTitle: true,
        ),
        body: tipo.isEmpty
            ? FirstTab(
                tipoProd: '1',
              )
            : Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    tabs: [
                      for (int c = 0; c < tipoTamanho; c++)
                        Tab(
                          child: Text(
                            '${tipo[c]}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        for (int t = 0; t < tipoTamanho; t++)
                          FirstTab(
                            tipoProd: '1',
                          )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
