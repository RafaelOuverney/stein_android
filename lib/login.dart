import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stein/main.dart';

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Column(children: [
      const SizedBox(height: 200,),
      SizedBox(height: 200, child: Image.asset('lib/assets/logo.png',)),
      SizedBox(height: 125, child: Text('STEIN', style: GoogleFonts.josefinSans(textStyle: TextStyle(fontSize: 25)),),),
      SizedBox(height: 50, width: 150,  child: FloatingActionButton.extended(backgroundColor: Colors.grey[800], 
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> const LoginPage()));
      }, 
      label:  Text('Login', style: GoogleFonts.josefinSans(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),), enableFeedback: true, hoverElevation: 25,))
    ]
    ,)
    ,)
    );
  }
}


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(child: Column(children: [
            const SizedBox(height: 25,),
            SizedBox(height: 100, child: Image.asset('lib/assets/logo.png',)),
            SizedBox(height: 25, child: Text('LOGIN', style: GoogleFonts.josefinSans(textStyle: const TextStyle(fontSize: 15)),),),
            const SizedBox(height: 50,),
            SizedBox(height: 100, width: 350, child: TextFormField(decoration: const InputDecoration(
              border: OutlineInputBorder(), 
              label: Text('Usuário'),
              prefixIcon: Icon(Icons.person),
              hintText:'Use seu CPF',
              
            ),
            ),
            ),
            SizedBox(height: 100, width: 350, child: TextFormField(decoration: const InputDecoration(
              border: OutlineInputBorder(), 
              label: Text('Senha'),
              prefixIcon: Icon(Icons.lock),
              hintText:'Insira sua senha',
            ),
            ) ,
            ),
            const SizedBox(height: 80,),
            SizedBox(height: 50, width: 150,  child: FloatingActionButton.extended(backgroundColor: Colors.grey[800], 
        onPressed: (){
          Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const FirstPage(),
      ),
      (route) => false,
    );
        }, 
        label:  Text('Login', style: GoogleFonts.josefinSans(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),), enableFeedback: true, hoverElevation: 25,),
        ),
         const SizedBox(height: 50,),
          ],
          ),
          ),
        ),
      )
      
    );
  }
}
