import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sobre extends StatefulWidget {
  const Sobre({super.key});

  @override
  State<Sobre> createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          automaticallyImplyLeading: true,
          title: Text(
            'Sobre',
            style: GoogleFonts.josefinSans(
                textStyle: const TextStyle(fontSize: 30)),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 25, top: 25, bottom: 10),
                  child: Text(
                    '  Objetivo:',
                    style: GoogleFonts.josefinSans(fontSize: 22, textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Center(
                    child: Text(
                      '  Oferecer um sistema simples e barato para pequenos e medios negocios, com enfase em venda de alimentos.',
                      style: GoogleFonts.josefinSans(fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 25, top: 25, bottom: 10),
                  child: Text(
                    '  Linguagens Usadas:',
                    style: GoogleFonts.josefinSans(fontSize: 22, textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Center(
                    child: Text(
                      '  Dentre as linguagens utilizadas temos: Python, Dart, Sql. Além da utilização de frameworks como o flutter e o Django.',
                      style: GoogleFonts.josefinSans(fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 25, top: 25, bottom: 10),
                  child: Text(
                    '  Prototipação:',
                    style: GoogleFonts.josefinSans(fontSize: 22, textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Center(
                    child: Text(
                      '  A prototipação foi feita utilizando-se da plataforma Figma®, introduzida em sala de aula pela professora Caroline Torsani.',
                      style: GoogleFonts.josefinSans(fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 25, top: 25, bottom: 10),
                  child: Text(
                    '  Agradecimentos:', 
                    style: GoogleFonts.josefinSans(fontSize: 22, textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Center(
                    child: Text(
                      '  Agradeçemos a todos que nos ajudaram a chegar até aqui, aos Professores do Colégio Estadual de Paranavaí-E.F.M.N.P. E aos nossos colegas e familiares que nos apoiaram.',
                      style: GoogleFonts.josefinSans(fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 25, top: 25, bottom: 10),
                  child: Text(
                    '  Projeto STEIN:',
                    style: GoogleFonts.josefinSans(fontSize: 22, textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Center(
                    child: Text(
                      '  Desenvolvido por: Giovana Garcia, Vitor Barbeiro, Rafael Ouverney.',
                      style: GoogleFonts.josefinSans(fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                  height: 200,
                  child: Center(
                    child: Image.asset('lib/assets/logo.png'),
                  )),
              SizedBox(
                height: 100,
                child: Text(
                  'STEIN',
                  style: GoogleFonts.josefinSans(
                      textStyle: const TextStyle(fontSize: 38)),
                ),
              ),
             
            ],
          ),
        ));
  }
}
