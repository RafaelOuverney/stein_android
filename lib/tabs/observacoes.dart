import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stein/tabs/first_page.dart';

import '../requisicao.dart';

class observacoes extends StatefulWidget {
  var idmesa = '';
  observacoes({super.key, required this.idmesa});

  @override
  State<observacoes> createState() => _observacoesState();
}

class _observacoesState extends State<observacoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Alguma observação?'),
      ),
      body: const SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: 350,
                child: TextField(
                  decoration: InputDecoration.collapsed(
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      hintText: 'Clique aqui para adicionar observações'),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: null,
                )),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        fazPedido(
          listaProd,
          widget.idmesa,
        );
      }),
    );
  }
}
