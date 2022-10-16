import 'package:flutter/material.dart';
import 'package:stein/tabs/first_page.dart';
import 'package:stein/tabs/second_page.dart';
import 'package:stein/tabs/thirth_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            title: const Text('Mesa: '),
            titleSpacing: 27,
            centerTitle: true,
          ),
          body: Column(
            children: const [
              TabBar(
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.restaurant,
                      color: Colors.black,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.wine_bar_rounded,
                      color: Colors.black,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.fastfood_rounded,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [FirstTab(), SecondTab(), ThirthTab()],
                ),
              )
            ],
          ),
        ));
  }
}
