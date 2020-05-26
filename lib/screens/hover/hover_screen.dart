import 'package:flutter/material.dart';
import 'package:flutter_sample/screens/hover/balloon.dart';

class HoverScreen extends StatelessWidget {
  static const routeName = '/hover';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAEAEA),
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 30),
            Balloon(
              child: Container(
                width: 250,
                height: 50,
                color: Colors.blueAccent,
                child: Center(
                  child: Text('show hover'),
                ),
              ),
            ),
            SizedBox(height: 100),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Balloon(
                child: Container(
                  width: 250,
                  height: 50,
                  color: Colors.blueAccent,
                  child: Center(
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
