import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class HalfCircleButtonScreen extends StatelessWidget {
  static const routeName = '/half_circle_button';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HalfCircleButton'),
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: HalfCircleButton(),
        ),
      ),
    );
  }
}

class HalfCircleButton extends StatefulWidget {
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
    return Stack(
      children: <Widget>[
        AnimatedOpacity(
          opacity: isHighlight ? 1 : 0,
          duration: Duration(milliseconds: 200),
          child: Transform.scale(
            scale: 1.5,
            alignment: Alignment.bottomCenter,
            child: CustomPaint(
              painter: HalfCirclePainter2(
                strokeColor: Colors.white,
              ),
              child: SizedBox(
                width: 324,
                height: 162,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _handleTap(context);
            print('tap!!!!');
          },
          onTapDown: _handleTapDown,
          onTapCancel: _handleTapCancel,
          child: CustomPaint(
            painter: HalfCirclePainter(
              color: Colors.blue,
              strokeColor: Colors.lightBlue,
              strokeWidth: 52,
            ),
            child: SizedBox(
              width: 324,
              height: 162,
            ),
          ),
        ),
      ],
    );
  }
}

class HalfCirclePainter extends CustomPainter {
  HalfCirclePainter({
    this.color,
    this.strokeColor,
    this.strokeWidth = 3,
  });

  final Color color;
  final Color strokeColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    if (strokeColor != null) {
      Paint strokePaint = Paint()
        ..color = strokeColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawPath(getHalfCirclePath(size.width, size.height), strokePaint);
    }

    if (color != null) {
      Paint fillPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      canvas.drawPath(getHalfCirclePath(size.width, size.height), fillPaint);
    }
  }

  Path getHalfCirclePath(double x, double y) {
    num degToRad(num deg) => deg * (math.pi / 180.0);
    return Path()
      ..moveTo(0, y)
      ..arcTo(
        Rect.fromCenter(center: Offset(x / 2, y), width: x, height: y * 2),
        degToRad(180),
        degToRad(180),
        false,
      );
  }

  @override
  bool shouldRepaint(HalfCirclePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeColor != strokeColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

class HalfCirclePainter2 extends CustomPainter {
  HalfCirclePainter2({
    this.strokeColor = Colors.black,
  });

  final Color strokeColor;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.white, Colors.white, Colors.white12],
        stops: [0, 0.8, 1],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height * 2))
      ..style = PaintingStyle.fill;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    num degToRad(num deg) => deg * (math.pi / 180.0);
    return Path()
      ..moveTo(0, y)
      ..arcTo(
        Rect.fromCenter(center: Offset(x / 2, y), width: x, height: y * 2),
        degToRad(180),
        degToRad(180),
        false,
      );
  }

  @override
  bool shouldRepaint(HalfCirclePainter2 oldDelegate) {
    return oldDelegate.strokeColor != strokeColor;
  }
}
