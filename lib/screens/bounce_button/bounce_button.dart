import 'package:flutter/material.dart';

// ref: https://medium.com/flutter-community/flutter-bouncing-button-animation-ece660e19c91
class BounceButton extends MaterialButton {
  BounceButton({
    Key key,
    @required VoidCallback onPressed,
    VoidCallback onLongPress,
    ButtonTextTheme textTheme,
    Color textColor,
    Color disabledTextColor,
    Color color,
    Color disabledColor,
    Brightness colorBrightness,
    double elevation = 0,
    EdgeInsetsGeometry padding,
    ShapeBorder shape,
    Clip clipBehavior = Clip.none,
    FocusNode focusNode,
    bool autofocus = false,
    MaterialTapTargetSize materialTapTargetSize,
    Duration animationDuration = kThemeChangeDuration,
    Widget child,
    this.ratio = 0.95,
  })  : assert(autofocus != null),
        assert(clipBehavior != null),
        super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          textTheme: textTheme,
          textColor: textColor,
          disabledTextColor: disabledTextColor,
          color: color,
          disabledColor: disabledColor,
          colorBrightness: colorBrightness,
          elevation: elevation,
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
      onLongPress: onLongPress,
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
    this.onLongPress,
    this.child,
    this.ratio = 0.95,
    this.animationDuration = kThemeChangeDuration,
    this.scaleAlignment = Alignment.center,
  });

  final VoidCallback onPressed;
  final VoidCallback onLongPress;
  final Widget child;
  final double ratio;
  final Duration animationDuration;
  final Alignment scaleAlignment;

  bool get enabled => onPressed != null || onLongPress != null;

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
    if (!widget.enabled) {
      return;
    }

    _tickerFuture = _controller.forward();
  }

  void _reverseAnimation() {
    if (!widget.enabled) {
      return;
    }

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
      onLongPress: widget.onLongPress,
      child: ScaleTransition(
        scale: _scale,
        alignment: widget.scaleAlignment,
        child: widget.child,
      ),
    );
  }
}
