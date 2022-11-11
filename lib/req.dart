import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stein/login.dart';
import 'package:stein/requisicao.dart';

class Rq extends StatefulWidget {
  const Rq({super.key});

  @override
  State<Rq> createState() => _RqState();
}

class _RqState extends State<Rq> {
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (() {
                if (formkey.currentState!.validate()) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => Login(),
                    ),
                    (route) => false,
                  );
                }
              }),
              icon: Icon(Icons.save))
        ],
      ),
      body: SafeArea(
        child: Form(
          key: formkey,
          child: Center(
            child: TextFormField(
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: const Text('Ip RestFramework'),
                  hintText: req),
              validator: (value) {
                if (value!.isEmpty) {
                  req = value;
                } else {
                  req = value;
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
