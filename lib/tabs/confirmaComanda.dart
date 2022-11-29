import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stein/tabs/first_page.dart';

class ConfirmaComanda extends StatefulWidget {
  var mesa = '';
  var dici = [];
  ConfirmaComanda({super.key, required this.mesa});

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
      body: listaProd.isEmpty
          ? Center(
              child: Text(
                'Essa messa ainda não possui pedidos',
                style: GoogleFonts.inter(textStyle: TextStyle(fontSize: 17)),
              ),
            )
          : ListView.builder(
              itemCount: listaProd.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  title: Text('${listaProd[index]['nome']}'),
                  trailing: Text(
                      '${listaProd[index]['quantidade']} X R\$ ${listaProd[index]['preco']}'),
                );
              }),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.task_alt,
          size: 25,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey[200],
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        child: Container(
          height: 25,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      extendBody: false,
      resizeToAvoidBottomInset: true,
    );
  }
}
