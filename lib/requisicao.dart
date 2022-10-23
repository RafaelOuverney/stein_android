// ignore_for_file: implementation_imports, avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:http/http.dart' as http;

var mesas = [];
var mesasOcup = [];
var qtdMesas = 0;

class RequisicaoHttp extends StatefulWidget {
  const RequisicaoHttp({super.key});

  @override
  State<RequisicaoHttp> createState() => HttpRequest();
}

class HttpRequest extends State<RequisicaoHttp> {
  Future<void> reqHTTP(site) async {
    var url = Uri.http(
        '10.0.2.2:7272', 'djangorestframeworkapi/$site', {'q': '{http}'});

    var response = await http.get(url);

    if (response.statusCode == 200 && site == 'Mesa/') {
      mesas = [];
      mesasOcup = [];
      var list = json.decode(response.body) as List;

      list.forEach((element) {
        mesas.add(element['numero']);
        if (element['ocupada']) {
          mesasOcup.add(element['numero']);
        }
      });
      qtdMesas = mesas.length;
    } else {
      print('error');
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