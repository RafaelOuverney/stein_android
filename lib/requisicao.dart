// ignore_for_file: implementation_imports, avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:http/http.dart' as http;

var mesas = [];
var mesasOcup = [];
var qtdMesas = 0;
var tipo = [];
var tipoTamanho = 0;
var authUsername = [];
var mesaComandaId = [];

String user = 'admin ';
String password = 'admim';

class RequisicaoHttp extends StatefulWidget {
  const RequisicaoHttp({super.key});

  @override
  State<RequisicaoHttp> createState() => HttpRequest();
}

class HttpRequest extends State<RequisicaoHttp> {
  String basicAuth = base64.encode(utf8.encode('$user:$password'));
  Future<void> reqHTTP(site) async {
    var url = Uri.http(
      'localhost:7272',
      'djangorestframeworkapi/$site',
    );

    var response = await http.get(url);

    if (response.statusCode == 200 && site == 'Mesa/') {
      mesas = [];
      mesasOcup = [];
      var list = json.decode(utf8.decode(response.bodyBytes)) as List;

      list.forEach((element) {
        mesas.add(element['numero']);
        if (element['ocupada']) {
          mesasOcup.add(element['numero']);
        }
      });
      qtdMesas = mesas.length;
    } else if (response.statusCode == 200 && site == 'TiposDeProduto/') {
      tipo = [];

      var tipos = json.decode(utf8.decode(response.bodyBytes)) as List;

      tipos.forEach((element) {
        tipo.add(element['tipo']);
      });
      tipoTamanho = tipo.length;
    } else if (response.statusCode == 200 && site == 'Users/') {
      authUsername = [];

      var username = json.decode(utf8.decode(response.bodyBytes)) as List;

      username.forEach((element) {
        authUsername.add(element['username']);
      });
    } else if (response.statusCode == 200 && site == 'Comanda/') {
      mesaComandaId = [];

      var mesaid = json.decode(utf8.decode(response.bodyBytes)) as List;

      mesaid.forEach((element) {
        mesaComandaId.add(element['nmrMesa']);
        print(mesaComandaId);
      });
    } else {
      throw (Exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}








// if (response.statusCode == 200 && site == 'Produtos/') {
//       tipo = [];
//       var list = json.decode(response.body) as List;

//       list.forEach((element) {
//         tipo.add(element['nome']);
//       });