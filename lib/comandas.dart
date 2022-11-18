import 'package:flutter/material.dart';

class Comandas extends StatefulWidget {
  var nummesa = '';
  Comandas({super.key, required this.nummesa});

  @override
  State<Comandas> createState() => _ComandasState();
}

class _ComandasState extends State<Comandas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 125,
        title: Text(
          'Comanda mesa: ${widget.nummesa}',
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
