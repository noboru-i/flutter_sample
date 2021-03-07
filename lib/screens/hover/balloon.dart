import 'package:flutter/material.dart';

class Balloon extends StatefulWidget {
  const Balloon({this.child});

  final Widget child;

  @override
  _BalloonState createState() => _BalloonState();
}

class _BalloonState extends State<Balloon> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  OverlayEntry _entry;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: kThemeAnimationDuration,
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          _removeEntry();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _removeEntry();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleOnTap,
      child: widget.child,
    );
  }

  void _handleOnTap() {
    if (_entry != null) {
      _controller.reverse();
      return;
    }

    _createNewEntry();
    _controller.forward();
  }

  void _removeEntry() {
    _entry?.remove();
    _entry = null;
  }

  void _createNewEntry() {
    final box = context.findRenderObject() as RenderBox;
    final target = box.localToGlobal(Offset.zero);

    _entry = OverlayEntry(
      builder: (BuildContext context) => _BalloonOverlay(
        animation: CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
        ),
        target: target,
        removeOverlay: () {
          _controller.reverse();
        },
      ),
    );
    Overlay.of(context, debugRequiredFor: widget).insert(_entry);
  }
}

// inspired by Tooltip in material/tooltip.dart.
class _BalloonOverlay extends StatelessWidget {
  const _BalloonOverlay({
    this.animation,
    this.target,
    this.removeOverlay,
  });

  final Animation<double> animation;
  final Offset target;
  final void Function() removeOverlay;

  static const borderRadius = 10.0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: GestureDetector(
            onTap: removeOverlay,
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        Positioned(
          left: target.dx,
          bottom: screenSize.height - target.dy,
          child: FadeTransition(
            opacity: animation,
            child: _buildBalloon(context),
          ),
        ),
      ],
    );
  }

  Widget _buildBalloon(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Material(
          elevation: 16,
          borderRadius: const BorderRadius.all(
            Radius.circular(borderRadius),
          ),
          child: SizedBox(
            height: 52,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildLeftButton(context),
                Container(
                  width: 1,
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  color: const Color(0xFFEAEAEA),
                ),
                _buildRightButton(context),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: const CustomPaint(
            painter: TrianglePainter(
              fillColor: Colors.white,
            ),
            child: SizedBox(
              width: 10,
              height: 8,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeftButton(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Tap Sample1');
        removeOverlay();
      },
      customBorder: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          'Sample1',
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 14,
              ),
        ),
      ),
    );
  }

  Widget _buildRightButton(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Tap Sample2');
        removeOverlay();
      },
      customBorder: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          'Sample2',
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 14,
              ),
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  const TrianglePainter({
    this.fillColor,
  });

  final Color fillColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(x / 2, y)
      ..lineTo(x, 0)
      ..lineTo(0, 0);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.fillColor != fillColor;
  }
}
