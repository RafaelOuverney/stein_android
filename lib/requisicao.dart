// ignore_for_file: implementation_imports, avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:stein/tabs/first_page.dart';

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
var produtos = [];
var comandas = [];
var produtosPerComanda = [];
var quantidadeProdutosPerComanda = 0;
var produtosP = [];
var funcionarioId = '';

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
      listMesas = [];
      garcomChamado = [];
      var list = json.decode(utf8.decode(response.bodyBytes)) as List;

      list.forEach((element) {
        var dict = <String, String>{
          'id': '${element["id"]}',
          'numero': '${element["numero"]}',
          'ocupada': '${element["ocupada"]}',
          'garcom': '${element["garcom"]}',
          'valorTotal': '0',
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
      requisitaComandas();

      qtdMesas = mesas.length;
    } else if (response.statusCode == 200 && site == 'TiposDeProduto/') {
      tipo = [];

      var tipos = json.decode(utf8.decode(response.bodyBytes)) as List;

      tipos.forEach((element) {
        var dicionario = {
          'nome': '${element['tipo']}',
          'id': '${element['id']}'
        };
        tipo.add(dicionario);
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
      });
    } else if (funcionarioResponse.statusCode == 200 &&
        site == 'Funcionarios/') {
      dadosUsuario = [];

      var dadosUser =
          json.decode(utf8.decode(funcionarioResponse.bodyBytes)) as List;

      funcionarioNome =
          dadosUser[0]['primeiro_nome'] + ' ${dadosUser[0]['segundo_nome']}';

      funcionarioId = dadosUser[0]['id'];

      var funcFuncao = await requisitaFuncao(dadosUser[0]['funcao']);
      funcionarioFuncao = funcFuncao['nome'];
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

Future respondeChamado(numeroMesaId, numeroMesa) async {
  // ignore: unused_local_variable
  http.Response chamado = await http.put(
      Uri.http(req.toString(), 'djangorestframeworkapi/Mesa/$numeroMesaId/'),
      headers: {
        'Authorization': 'Token $tokenzinho',
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({'garcom': false, 'numero': numeroMesa}));
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

  //valor total das mesas

  var comandas = json.decode(utf8.decode(response.bodyBytes)) as List;
  for (var c = 0; c < comandas.length; c++) {
    for (var i = 0; i < listMesas.length; i++) {
      if (comandas[c]['nmrMesa'].toString() == listMesas[i]['id'].toString()) {
        listMesas[i]['valorTotal'] = comandas[c]['valorTotal'];
        break;
      }
    }
  }

  // ignore: unused_local_variable
  var mesa = json.decode(utf8.decode(response.bodyBytes)) as List;
  var numemesa = [];
  numemesa.forEach((element) {
    numemesa.add(element['nmrMesa']);
  });
}

requisitaPedidos(nummesa) async {
  produtos = [];
  comandas = [];
  final parametros = {'encerrada': "False", 'idMesa': nummesa};

  var url =
      Uri.http(req.toString(), 'djangorestframeworkapi/Comanda/', parametros);
  var response =
      await http.get(url, headers: {'Authorization': 'Token $tokenzinho'});

  var produtosList = json.decode(utf8.decode(response.bodyBytes)) as List;
  produtosList.forEach((element) {
    produtos.add(element['produtos']);
    comandas.add(element['id']);
  });

  await produtosPorComanda();
}

produtosPorComanda() async {
  var lista = [];
  for (var p = 0; p < produtos[0].length; p++) {
    var parametros = {'id': produtos[0][p].toString()};

    var url = Uri.http(
        req.toString(), 'djangorestframeworkapi/Produtos/', parametros);
    var response =
        await http.get(url, headers: {'Authorization': 'Token $tokenzinho'});

    var produtosDetalhes = json.decode(utf8.decode(response.bodyBytes)) as List;
    produtosDetalhes.forEach((element) {
      var dict = <String, String>{
        'nome': '${element["nome"]}',
        'preco': '${element["preco"]}',
        'id': '${element['id']}',
        'imagem': '${element['imagem']}'
      };
      lista.add(dict);
    });
  }
  await comandaProdutos(lista);
}

comandaProdutos(dadosProduto) async {
  var parametros = {'comanda': comandas[0].toString()};

  var url = Uri.http(
      req.toString(), 'djangorestframeworkapi/ComandaProduto/', parametros);
  var response =
      await http.get(url, headers: {'Authorization': 'Token $tokenzinho'});

  var quantidadeProdutos = json.decode(utf8.decode(response.bodyBytes)) as List;
  var list = [];
  quantidadeProdutos.forEach((element) {
    var dict = <String, String>{
      'produto': '${element["produto"]}',
      'quantidade': '${element["quantidade"]}'
    };
    list.add(dict);
  });

  for (var c = 0; c < dadosProduto.length; c++) {
    for (var i = 0; i < list.length; i++) {
      if (dadosProduto[c]['id'].toString() == list[i]['produto'].toString()) {
        dadosProduto[c]['quantidade'] = list[i]['quantidade'];

        break;
      }
    }
  }
  produtosPerComanda = dadosProduto;
  quantidadeProdutosPerComanda = produtosPerComanda.length;
}

Future produtosReq() async {
  produtosP = [];
  filter = [];
  var url = Uri.http(req.toString(), 'djangorestframeworkapi/Produtos/');

  var response =
      await http.get(url, headers: {'Authorization': 'Token $tokenzinho'});

  var produtosPp = json.decode(utf8.decode(response.bodyBytes)) as List;

  produtosPp.forEach((element) {
    var dici = {
      'nome': '${element['nome']}',
      'imagem': '${element['imagem']}',
      'preco': '${element['preco']}',
      'id': '${element['tipoProduto']}',
      'descrição': '${element['descricao']}',
      'quantidade': 0
    };

    produtosP.add(dici);
  });

  filter.addAll(produtosP);
  filter.retainWhere((element) => element['id'] == separador);
}
