import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class HalfCircleButtonScreen extends StatelessWidget {
  static const routeName = '/half_circle_button';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HalfCircleButton'),
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black,
              width: 324,
              height: 162,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: HalfCircleButton(
              width: 324,
              height: 162,
              strokeWidth: 16,
              direction: AxisDirection.down,
              color: Colors.blue,
              strokeColor: Colors.lightBlue,
              hightColor: Colors.white,
              onTap: () {
                print('tap!!!!');
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              color: Colors.black,
              width: 95,
              height: 190,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: HalfCircleButton(
              width: 95,
              height: 190,
              strokeWidth: 16,
              direction: AxisDirection.right,
              color: Colors.blue,
              strokeColor: Colors.lightBlue,
              hightColor: Colors.white,
              onTap: () {
                print('tap!!!!');
              },
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: Colors.black,
              width: 324,
              height: 162,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: HalfCircleButton(
              width: 324,
              height: 162,
              strokeWidth: 16,
              direction: AxisDirection.up,
              color: Colors.blue,
              strokeColor: Colors.lightBlue,
              hightColor: Colors.white,
              onTap: () {
                print('tap!!!!');
              },
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              color: Colors.black,
              width: 95,
              height: 190,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: HalfCircleButton(
              width: 95,
              height: 190,
              strokeWidth: 16,
              direction: AxisDirection.left,
              color: Colors.blue,
              strokeColor: Colors.lightBlue,
              hightColor: Colors.white,
              onTap: () {
                print('tap!!!!');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HalfCircleButton extends StatefulWidget {
  HalfCircleButton({
    this.width,
    this.height,
    this.strokeWidth,
    this.direction,
    this.color,
    this.strokeColor,
    this.hightColor,
    this.onTap,
  });

  final double width;
  final double height;
  final double strokeWidth;
  final AxisDirection direction;
  final Color color;
  final Color strokeColor;
  final Color hightColor;
  final GestureTapCallback onTap;

  @override
  _HalfCircleButtonState createState() => _HalfCircleButtonState();
}

class _HalfCircleButtonState extends State<HalfCircleButton> {
  bool isHighlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      isHighlight = true;
    });

    // after few milliseconds, automatically hide highlight.
    Timer(Duration(milliseconds: 200), () {
      setState(() {
        isHighlight = false;
      });
    });
  }

  void _handleTap(BuildContext context) {
    setState(() {
      isHighlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      isHighlight = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final alignment = _alignment();
    final radius = widget.width > widget.height ? widget.height : widget.width;

    return Stack(
      children: <Widget>[
        AnimatedOpacity(
          opacity: isHighlight ? 1 : 0,
          duration: Duration(milliseconds: 200),
          child: Transform.scale(
            scale: (radius + widget.strokeWidth) / radius,
            alignment: alignment,
            child: CustomPaint(
              painter: HalfCirclePainter(
                color: widget.hightColor,
                direction: widget.direction,
              ),
              size: Size(widget.width, widget.height),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _handleTap(context);
            widget.onTap();
          },
          onTapDown: _handleTapDown,
          onTapCancel: _handleTapCancel,
          child: Stack(
            alignment: alignment,
            children: <Widget>[
              // outer circle
              CustomPaint(
                painter: HalfCirclePainter(
                  color: widget.strokeColor,
                  direction: widget.direction,
                ),
                size: Size(widget.width, widget.height),
              ),
              // inner circle
              CustomPaint(
                painter: HalfCirclePainter(
                  color: widget.color,
                  direction: widget.direction,
                ),
                size: Size(
                  widget.width -
                      widget.strokeWidth *
                          (widget.direction == AxisDirection.down ||
                                  widget.direction == AxisDirection.up
                              ? 2
                              : 1),
                  widget.height -
                      widget.strokeWidth *
                          (widget.direction == AxisDirection.down ||
                                  widget.direction == AxisDirection.up
                              ? 1
                              : 2),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Alignment _alignment() {
    switch (widget.direction) {
      case AxisDirection.up:
        return Alignment.topCenter;
      case AxisDirection.right:
        return Alignment.centerRight;
      case AxisDirection.down:
        return Alignment.bottomCenter;
      case AxisDirection.left:
        return Alignment.centerLeft;
    }
    return null;
  }
}

class HalfCirclePainter extends CustomPainter {
  HalfCirclePainter({
    @required this.color,
    this.direction = AxisDirection.down,
  });

  final Color color;
  final AxisDirection direction;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(
      _getHalfCirclePath(size.width, size.height),
      paint,
    );
  }

  Path _getHalfCirclePath(double x, double y) {
    num degToRad(num deg) => deg * (math.pi / 180.0);

    final offset = _getOffset(x, y);
    final startAngle = _getStartAngle();
    return Path()
      ..moveTo(offset.dx, offset.dy)
      ..arcTo(
        _getRect(x, y),
        degToRad(startAngle),
        degToRad(180),
        false,
      );
  }

  @override
  bool shouldRepaint(HalfCirclePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.direction != direction;
  }

  Offset _getOffset(double x, double y) {
    switch (direction) {
      case AxisDirection.up:
        return Offset(x, 0);
      case AxisDirection.right:
        return Offset(x, y);
      case AxisDirection.down:
        return Offset(0, y);
      case AxisDirection.left:
        return Offset(0, 0);
    }
    return null;
  }

  num _getStartAngle() {
    switch (direction) {
      case AxisDirection.up:
        return 0;
      case AxisDirection.right:
        return 90;
      case AxisDirection.down:
        return 180;
      case AxisDirection.left:
        return 270;
    }
    return null;
  }

  Rect _getRect(double x, double y) {
    switch (direction) {
      case AxisDirection.up:
        return Rect.fromCenter(
            center: Offset(x / 2, 0), width: x, height: y * 2);
      case AxisDirection.right:
        return Rect.fromCenter(
            center: Offset(x, y / 2), width: x * 2, height: y);
      case AxisDirection.down:
        return Rect.fromCenter(
            center: Offset(x / 2, y), width: x, height: y * 2);
      case AxisDirection.left:
        return Rect.fromCenter(
            center: Offset(0, y / 2), width: x * 2, height: y);
    }
    return null;
  }
}
