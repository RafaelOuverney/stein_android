import 'package:flutter/material.dart';

class FirstTab extends StatelessWidget {
  const FirstTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
            child: Row(
          children: [
            Container(
              child: SizedBox(
                width: 250,
                child: Container(
                  color: Colors.red,
                ),
              ),
            )
          ],
        )),
      ),
    ));
  }
}
