import 'package:flutter/material.dart';

class BounceButtonScreen extends StatefulWidget {
  static const routeName = '/bounce_button';

  BounceButtonScreen({Key key}) : super(key: key);

  @override
  _BounceButtonScreenState createState() => _BounceButtonScreenState();
}

class _BounceButtonScreenState extends State<BounceButtonScreen> {
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
    Brightness colorBrightness,
    EdgeInsetsGeometry padding,
    ShapeBorder shape,
    Clip clipBehavior = Clip.none,
    FocusNode focusNode,
    bool autofocus = false,
    MaterialTapTargetSize materialTapTargetSize,
    Duration animationDuration = kThemeChangeDuration,
    Widget child,
    this.ratio = 1.05,
  })  : assert(autofocus != null),
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
          colorBrightness: colorBrightness,
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
      animationDuration: animationDuration,
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
    this.animationDuration,
  });

  final VoidCallback onPressed;
  final Widget child;
  final double ratio;
  final Duration animationDuration;

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
      duration: widget.animationDuration,
    );
    _scale = _controller
        .drive(
          CurveTween(curve: Curves.linear),
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
