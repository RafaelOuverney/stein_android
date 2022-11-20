// ignore_for_file: implementation_imports, avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:http/http.dart' as http;
import 'req.dart';

var mesas = [];
var mesasOcup = [];
var qtdMesas = 0;
var tipo = [];
var tipoTamanho = 0;
var authUsername = [];
var mesaComandaId = [];
String? req = '10.0.2.2:8000';
var authToken = '';
var tokenzinho = 'invalido';
var authPassword = '';
var authUsuario = '';

class Token extends StatefulWidget {
  const Token({super.key});

  @override
  State<Token> createState() => TokenRequest();
}

class TokenRequest extends State<Token> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class RequisicaoHttp extends StatefulWidget {
  const RequisicaoHttp({super.key});

  @override
  State<RequisicaoHttp> createState() => HttpRequest();
}

class HttpRequest extends State<RequisicaoHttp> {
  Future<void> reqHTTP(site) async {
    var url = Uri.http(req.toString(), 'djangorestframeworkapi/$site');

    var response =
        await http.get(url, headers: {'Authorization': 'Token $tokenzinho'});

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
        mesaComandaId.add(element['id']);
        print(mesaComandaId);
      });
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Future chamaToken(usuario, senha) async {
  tokenzinho = 'invalido';
  print(usuario);
  print(senha);
  http.Response resposta = await http.post(
    Uri.http(req.toString(), '/djangorestframeworkapi/verifica-token/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{'username': '$usuario', 'password': '$senha'}),
  );
  if (resposta.statusCode == 200) {
    tokenzinho = json.decode(resposta.body)['token'];
    return true;
  } else {
    tokenzinho = 'invalido';
    return false;
  }
}
