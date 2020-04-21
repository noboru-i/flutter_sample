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
        color: Colors.black54,
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
          duration: Duration(milliseconds: 250),
          child: Transform.scale(
            scale: 1.25,
            alignment: Alignment.bottomCenter,
            child: CustomPaint(
              painter: HalfCirclePainter(
                strokeColor: Colors.white,
                paintingStyle: PaintingStyle.fill,
              ),
              child: SizedBox(
                width: 200,
                height: 100,
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
          child: Stack(
            children: <Widget>[
              CustomPaint(
                painter: HalfCirclePainter(
                  strokeColor: Colors.blue,
                  strokeWidth: 10,
                  paintingStyle: PaintingStyle.fill,
                ),
                child: SizedBox(
                  width: 200,
                  height: 100,
                ),
              ),
              CustomPaint(
                painter: HalfCirclePainter(
                  strokeColor: Colors.lightBlue,
                  strokeWidth: 10,
                  paintingStyle: PaintingStyle.stroke,
                ),
                child: SizedBox(
                  width: 200,
                  height: 100,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HalfCirclePainter extends CustomPainter {
  HalfCirclePainter({
    this.strokeColor = Colors.black,
    this.strokeWidth = 3,
    this.paintingStyle = PaintingStyle.stroke,
  });

  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

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
  bool shouldRepaint(HalfCirclePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
