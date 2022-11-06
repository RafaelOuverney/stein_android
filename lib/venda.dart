import 'package:flutter/material.dart';
import 'package:stein/requisicao.dart';
import 'package:stein/tabs/first_page.dart';
import 'package:stein/tabs/second_page.dart';
import 'package:stein/tabs/thirth_page.dart';

import 'main.dart';

class HomePage extends StatefulWidget  {
  String nmrMesa = '';
  String ocup = '';

  HomePage({super.key, required this.nmrMesa, required this.ocup});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initSate(){
    super.initState();

    load();
  }

  Future load() async{
    showDialog(context: context, builder: (context){
      return const Center(child: CircularProgressIndicator(),);
    });
    setState(() {
       updateVenda();
    });
     

    Navigator.pop;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tipoTamanho,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              Container(
                padding: const EdgeInsets.all(25),
                child: Center(
                  child: Text(
                    widget.ocup,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
            toolbarHeight: 100,
            title: Text('Mesa: ${widget.nmrMesa}'),
            titleSpacing: 27,
            centerTitle: true,
          ),
          body: tipo.isEmpty ? Center(child: CircularProgressIndicator()) : 
          Column(
              children: [
                TabBar(
                  isScrollable: true,
                  tabs: [
                    for (int c = 0; c < tipoTamanho; c++)
                      Tab(
                        child: Text(
                          '${tipo[c]}',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      for (int t = 0; t < tipoTamanho; t++) FirstTab()
                    ],
                  ),
                )
              ],
            ),
          ),
        );
  }
}
