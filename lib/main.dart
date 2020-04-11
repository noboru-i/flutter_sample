import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            RaisedButton(
              onPressed: _incrementCounter,
              child: Text('RaisedButton'),
            ),
            FlatButton(
              onPressed: _incrementCounter,
              child: Text('FlatButton'),
            ),
            BounceButton(
              onPressed: _incrementCounter,
              child: Container(
                color: Colors.lightBlue,
                padding: const EdgeInsets.all(12),
                child: Text('BounceButton'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

// ref: https://medium.com/flutter-community/flutter-bouncing-button-animation-ece660e19c91
class BounceButton extends StatefulWidget {
  BounceButton({
    @required this.onPressed,
    this.child,
    this.ratio = 1.05,
  });

  final VoidCallback onPressed;
  final Widget child;
  final double ratio;

  @override
  _BounceButtonState createState() => _BounceButtonState();
}

class _BounceButtonState extends State<BounceButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _scale = _controller
        .drive(
          CurveTween(curve: Curves.slowMiddle),
        )
        .drive(
          Tween(begin: 1, end: widget.ratio),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onPressed,
      child: ScaleTransition(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}
