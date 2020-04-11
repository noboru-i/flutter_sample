import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF4F3EF),
//        buttonTheme: const ButtonThemeData(
//          buttonColor: Colors.yellow,
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.all(Radius.circular(100)),
//          ),
//          textTheme: ButtonTextTheme.primary,
//        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

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
        title: Text('Flutter Demo Home Page'),
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
              child: Text('BounceButton'),
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
class BounceButton extends MaterialButton {
  BounceButton({
    Key key,
    @required VoidCallback onPressed,
    VoidCallback onLongPress,
    ValueChanged<bool> onHighlightChanged,
    ButtonTextTheme textTheme,
    Color textColor,
    Color disabledTextColor,
    Color color,
    Color disabledColor,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color splashColor,
    Brightness colorBrightness,
    double elevation,
    double focusElevation,
    double hoverElevation,
    double highlightElevation,
    double disabledElevation,
    EdgeInsetsGeometry padding,
    ShapeBorder shape,
    Clip clipBehavior = Clip.none,
    FocusNode focusNode,
    bool autofocus = false,
    MaterialTapTargetSize materialTapTargetSize,
    Duration animationDuration,
    Widget child,
    this.ratio = 1.05,
  })  : assert(autofocus != null),
        assert(elevation == null || elevation >= 0.0),
        assert(focusElevation == null || focusElevation >= 0.0),
        assert(hoverElevation == null || hoverElevation >= 0.0),
        assert(highlightElevation == null || highlightElevation >= 0.0),
        assert(disabledElevation == null || disabledElevation >= 0.0),
        assert(clipBehavior != null),
        super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHighlightChanged: onHighlightChanged,
          textTheme: textTheme,
          textColor: textColor,
          disabledTextColor: disabledTextColor,
          color: color,
          disabledColor: disabledColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          splashColor: splashColor,
          colorBrightness: colorBrightness,
          elevation: elevation,
          focusElevation: focusElevation,
          hoverElevation: hoverElevation,
          highlightElevation: highlightElevation,
          disabledElevation: disabledElevation,
          padding: padding,
          shape: shape,
          clipBehavior: clipBehavior,
          focusNode: focusNode,
          autofocus: autofocus,
          materialTapTargetSize: materialTapTargetSize,
          animationDuration: animationDuration,
          child: child,
        );

  final double ratio;

  @override
  Widget build(BuildContext context) {
    return BounceAnimation(
      onPressed: onPressed,
      ratio: ratio,
      child: AbsorbPointer(
        // stops propagation of tap events.
        child: super.build(context),
      ),
    );
  }
}

class BounceAnimation extends StatefulWidget {
  BounceAnimation({
    @required this.onPressed,
    this.child,
    this.ratio = 1.05,
  });

  final VoidCallback onPressed;
  final Widget child;
  final double ratio;

  @override
  _BounceAnimationState createState() => _BounceAnimationState();
}

class _BounceAnimationState extends State<BounceAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _scale;
  TickerFuture _tickerFuture;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 50),
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

  void _forwardAnimation() {
    _tickerFuture = _controller.forward();
  }

  void _reverseAnimation() {
    // start the reverse animation after the forward animation ends.
    _tickerFuture.whenCompleteOrCancel(() {
      _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _forwardAnimation(),
      onTapUp: (_) => _reverseAnimation(),
      onTapCancel: _reverseAnimation,
      onTap: widget.onPressed,
      child: ScaleTransition(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}
