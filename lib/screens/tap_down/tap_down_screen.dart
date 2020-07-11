import 'package:flutter/material.dart';

class TapDownScreen extends StatefulWidget {
  static const routeName = '/tap_down';

  @override
  _TapDownScreenState createState() => _TapDownScreenState();
}

class _TapDownScreenState extends State<TapDownScreen> {
  List<String> log = ['log'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CheckTapDownTime'),
      ),
      body: Stack(
        children: <Widget>[
          _buildRight(context),
          _buildLeft(context),
          Center(
            child: Text(log.join('\n')),
          ),
        ],
      ),
    );
  }

  Widget _buildRight(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTapDown: (_) => _onTapDown(),
        child: Container(
          width: 95,
          height: 190,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildLeft(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTapDown: (_) => _onTapDown(),
        child: Container(
          width: 95,
          height: 190,
          color: Colors.blue,
        ),
      ),
    );
  }

  void _onTapDown() {
    final now = DateTime.now();
    setState(() {
      log.add('$now tap down.');
    });
  }
}
