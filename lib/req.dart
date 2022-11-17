import 'package:flutter/material.dart';
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
        backgroundColor: Colors.grey[100],
        title: const Text('Não altere'),
        actions: [
          IconButton(
              onPressed: (() {
                if (formkey.currentState!.validate()) {
                  final snackBar = SnackBar(
                    content: const Text('Essa ação não podera ser revertida'),
                    action: SnackBarAction(
                      label: 'Continuar',
                      textColor: Colors.lightBlue,
                      onPressed: () {
                        final snackBar = SnackBar(
                          content: const Text(
                              'A aplicação pode deixar de funcionar'),
                          action: SnackBarAction(
                            label: 'Ok',
                            textColor: Colors.redAccent,
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Login(),
                                ),
                                (route) => false,
                              );
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }),
              icon: Icon(Icons.save))
        ],
      ),
      body: SafeArea(
        child: Column(children: [
          const SizedBox(
            child: Padding(
              padding: EdgeInsets.only(left: 25, right: 25, top: 25),
              child: Center(
                child: Text(
                  'Alterações nessa tela podem comprometer o funcionamento da aplicação',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 75,
          ),
          const SizedBox(
            height: 25,
            child: Center(
              child: Text('Endereço RestFramework Ex: 10.0.2.2:8000'),
            ),
          ),
          Form(
            key: formkey,
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: TextFormField(
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: const Text('Ip RestFramework'),
                      hintText: req),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe um endereço';
                    } else {
                      req = value;
                    }
                  },
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
