import 'package:flutter/material.dart';
import 'package:stein/venda.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FirstPage(),
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.deepPurple),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.arrow_back_ios_new_outlined),
              title: const Text('Voltar'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const UserAccountsDrawerHeader(
              accountName: Text('User'),
              accountEmail: Text('Email'),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Sair'),
              onTap: (() {}),
            )
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar.large(
            pinned: false,
            snap: false,
            floating: false,
            title: const Text('Stein'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const HomePage()));
                },
                icon: const Icon(Icons.more_vert_rounded),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 250,
              color: Colors.amber,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 250,
              color: Colors.amber,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 250,
              color: Colors.amber,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 250,
              color: Colors.amber,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 250,
              color: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }
}
