import 'package:flutter/material.dart';
import 'package:flutter_sample/screens/hover/balloon.dart';

class HoverScreen extends StatelessWidget {
  static const routeName = '/hover';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAEAEA),
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 30),
            Balloon(
              child: Container(
                width: 250,
                height: 50,
                color: Colors.blueAccent,
                child: const Center(
                  child: Text('show hover'),
                ),
              ),
            ),
            const SizedBox(height: 100),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Balloon(
                child: Container(
                  width: 250,
                  height: 50,
                  color: Colors.blueAccent,
                  child: const Center(
                    child: Text('show hover'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
