import 'package:flutter/material.dart';
import 'package:stein/tabs/first_page.dart';
import 'package:stein/tabs/second_page.dart';
import 'package:stein/tabs/thirth_page.dart';

int i = 9;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: i,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            title: const Text('Mesa: '),
            titleSpacing: 27,
            centerTitle: true,
          ),
          body: Column(
            children: [
              TabBar(
                isScrollable: true,
                tabs: [
                  for (int c = 0; c < i; c++)
                    Tab(
                      child: Text(
                        '$c',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [FirstTab(), SecondTab(), ThirthTab()],
                ),
              )
            ],
          ),
        ));
  }
}
