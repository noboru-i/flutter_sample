import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_sample/screens/bounce_button/bounce_button.dart';

class HalfCircleButtonScreen extends StatelessWidget {
  static const routeName = '/half_circle_button';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HalfCircleButton'),
      ),
      backgroundColor: Colors.blueGrey,
      body: Stack(
        children: <Widget>[
          _buildTop(context),
          _buildRight(context),
          _buildBottom(context),
          _buildLeft(context),
        ],
      ),
    );
  }

  Widget _buildTop(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: 324,
        height: 162,
        child: HalfCircleButton(
          strokeWidth: 16,
          direction: AxisDirection.up,
          color: Colors.blue,
          strokeColor: Colors.lightBlue,
          highlightColor: Colors.yellow,
          onTap: () {
            print('tapped top button');
          },
          child: Center(
            child: Text(
              'Top button',
              style: Theme.of(context).textTheme.display1.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRight(BuildContext context) {
    return Stack(
      children: <Widget>[
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
          child: Container(
            width: 95,
            height: 190,
            child: HalfCircleButton(
              strokeWidth: 16,
              direction: AxisDirection.right,
              color: Colors.blue,
              strokeColor: Colors.lightBlue,
              highlightColor: Colors.white,
              onTap: () {
                print('tapped right button');
              },
              child: Container(
                alignment: Alignment.centerRight,
                child: Transform.rotate(
                  angle: -math.pi / 2,
                  child: Text(
                    'Right\nbutton',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Stack(
      children: <Widget>[
        // For iPhone 11 Pro
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            width: 327,
            height: 163.5,
          ),
        ),
        // For iPhone SE 1st
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.black,
            width: 272,
            height: 136,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: BounceAnimation(
              scaleAlignment: Alignment.bottomCenter,
              onPressed: () {
                print('tapped bottom button');
              },
              child: AbsorbPointer(
                child: HalfCircleButton(
                  strokeWidth: 16,
                  direction: AxisDirection.down,
                  color: Colors.blue,
                  strokeColor: Colors.lightBlue,
                  highlightColor: Colors.white,
                  onTap: null,
                  child: SafeArea(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Bottom button',
                        style: Theme.of(context).textTheme.display1.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeft(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 95,
        height: 190,
        child: BounceAnimation(
          scaleAlignment: Alignment.centerLeft,
          onPressed: () {
            print('tapped left button');
          },
          child: AbsorbPointer(
            child: HalfCircleButton(
              strokeWidth: 16,
              direction: AxisDirection.left,
              color: Colors.blue,
              strokeColor: Colors.lightBlue,
              highlightColor: Colors.transparent,
              onTap: null,
            ),
          ),
        ),
      ),
    );
  }
}

class HalfCircleButton extends StatefulWidget {
  HalfCircleButton({
    this.strokeWidth,
    this.tapHighlightScale = 1.1,
    this.direction,
    this.color,
    this.strokeColor,
    this.highlightColor,
    this.onTap,
    this.child,
  });

  final double strokeWidth;
  final double tapHighlightScale;
  final AxisDirection direction;
  final Color color;
  final Color strokeColor;
  final Color highlightColor;
  final GestureTapCallback onTap;
  final Widget child;

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

    return AspectRatio(
      aspectRatio: widget.direction == AxisDirection.up ||
              widget.direction == AxisDirection.down
          ? 2 / 1
          : 1 / 2,
      child: Stack(
        children: <Widget>[
          // tap highlight
          AnimatedOpacity(
            opacity: isHighlight ? 1 : 0,
            duration: Duration(milliseconds: 200),
            child: Transform.scale(
              scale: widget.tapHighlightScale,
              alignment: alignment,
              child: CustomPaint(
                painter: HalfCirclePainter(
                  color: widget.highlightColor,
                  direction: widget.direction,
                ),
                child: Container(),
              ),
            ),
          ),
          // button area
          GestureDetector(
            onTap: () {
              _handleTap(context);
              widget.onTap();
            },
            onTapDown: _handleTapDown,
            onTapCancel: _handleTapCancel,
            behavior: HitTestBehavior.deferToChild,
            child: Stack(
              alignment: alignment,
              children: <Widget>[
                // outer circle
                CustomPaint(
                  painter: HalfCirclePainter(
                    color: widget.strokeColor,
                    direction: widget.direction,
                  ),
                  child: Container(),
                ),
                // inner circle
                Container(
                  padding: _edgeInsets(),
                  alignment: alignment,
                  child: CustomPaint(
                    painter: HalfCirclePainter(
                      color: widget.color,
                      direction: widget.direction,
                    ),
                    child: Container(),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: widget.child ?? Container(),
                ),
              ],
            ),
          ),
        ],
      ),
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

  EdgeInsets _edgeInsets() {
    switch (widget.direction) {
      case AxisDirection.up:
        return EdgeInsets.symmetric(horizontal: widget.strokeWidth) +
            EdgeInsets.only(bottom: widget.strokeWidth);
      case AxisDirection.right:
        return EdgeInsets.symmetric(vertical: widget.strokeWidth) +
            EdgeInsets.only(left: widget.strokeWidth);
      case AxisDirection.down:
        return EdgeInsets.symmetric(horizontal: widget.strokeWidth) +
            EdgeInsets.only(top: widget.strokeWidth);
      case AxisDirection.left:
        return EdgeInsets.symmetric(vertical: widget.strokeWidth) +
            EdgeInsets.only(right: widget.strokeWidth);
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

  Path _path;

  @override
  void paint(Canvas canvas, Size size) {
    _path = _getHalfCirclePath(size.width, size.height);
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(
      _path,
      paint,
    );
  }

  @override
  bool hitTest(Offset position) {
    if (_path == null) {
      return false;
    }
    return _path.contains(position);
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
          center: Offset(x / 2, 0),
          width: x,
          height: y * 2,
        );
      case AxisDirection.right:
        return Rect.fromCenter(
          center: Offset(x, y / 2),
          width: x * 2,
          height: y,
        );
      case AxisDirection.down:
        return Rect.fromCenter(
          center: Offset(x / 2, y),
          width: x,
          height: y * 2,
        );
      case AxisDirection.left:
        return Rect.fromCenter(
          center: Offset(0, y / 2),
          width: x * 2,
          height: y,
        );
    }
    return null;
  }
}
