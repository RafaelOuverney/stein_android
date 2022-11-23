// ignore_for_file: implementation_imports, avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

var mesas = [];
var listMesas = [];
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
var garcomChamado = [];
var dadosUsuario = [];
var funcionarioNome = '';
var funcionarioFuncao = '';
var funcaoFuncionario = '';

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
  final parametrosDeBusca = {'usuario': nominho};
  Future<void> reqHTTP(site) async {
    var url = Uri.http(req.toString(), 'djangorestframeworkapi/$site');

    var response =
        await http.get(url, headers: {'Authorization': 'Token $tokenzinho'});

    var funcionarioUri = Uri.http(req.toString(),
        'djangorestframeworkapi/Funcionarios/', parametrosDeBusca);

    var funcionarioResponse = await http
        .get(funcionarioUri, headers: {'Authorization': 'Token $tokenzinho'});

    if (response.statusCode == 200 && site == 'Mesa/') {
      mesas = [];
      mesasOcup = [];
      garcomChamado = [];
      var list = json.decode(utf8.decode(response.bodyBytes)) as List;

      list.forEach((element) {
        var dict = <String, String>{
          'id': '${element["id"]}',
          'numero': '${element["numero"]}'
        };
        listMesas.add(dict);
        mesas.add(element['numero']);
        if (element['ocupada']) {
          mesasOcup.add(element['numero']);
        }
        if (element['garcom']) {
          garcomChamado.add(element['numero']);
        }
      });
      print(listMesas);
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
        print(mesaid[0]);
      });
    } else if (funcionarioResponse.statusCode == 200 &&
        site == 'Funcionarios/') {
      dadosUsuario = [];

      var dadosUser =
          json.decode(utf8.decode(funcionarioResponse.bodyBytes)) as List;

      funcionarioNome =
          dadosUser[0]['primeiro_nome'] + ' ${dadosUser[0]['segundo_nome']}';

      var funcFuncao = await requisitaFuncao(dadosUser[0]['funcao']);
      funcionarioFuncao = funcFuncao['nome'];

      print(funcionarioFuncao);

      print(funcionarioNome);
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

Future respondeChamado(numeroMesa) async {
  http.Response chamado = await http.put(
      Uri.http(req.toString(), 'djangorestframeworkapi/Mesa/$numeroMesa/'),
      headers: {
        'Authorization': 'Token $tokenzinho',
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({'garcom': false, 'numero': numeroMesa}));

  print(chamado.body);
}

requisitaFuncao(site) async {
  var url = Uri.parse(site);
  var response =
      await http.get(url, headers: {'Authorization': 'Token $tokenzinho'});
  return json.decode(response.body);
}

requisitaComandas() async {
  final parametros = {'encerrada': "False"};
  var url =
      Uri.http(req.toString(), 'djangorestframeworkapi/Comanda/', parametros);
  var response =
      await http.get(url, headers: {'Authorization': 'Token $tokenzinho'});
  print(json.decode(response.body)[0]['valorTotal']);

  //valor total das mesas

  var comandas = json.decode(utf8.decode(response.bodyBytes)) as List;
  var valores = [];
  comandas.forEach((element) {
    valores.add(element['valorTotal']);
  });

  var mesa = json.decode(utf8.decode(response.bodyBytes)) as List;
  var numemesa = [];
  numemesa.forEach((element) {
    numemesa.add(element['nmrMesa']);
  });

  print(valores);
  print(numemesa);
}
