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
  final Function removeOverlay;

  static const heightBox = 52.0;
  static const heightTriangle = 7.0;
  static const space = 7.0;
  static const borderRadius = 10.0;

  @override
  Widget build(BuildContext context) {
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
          top: target.dy - (heightBox + heightTriangle + space),
          height: heightBox + heightTriangle,
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
          elevation: 2,
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
          child: Container(
            height: heightBox,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildLeftButton(context),
                Container(
                  width: 1,
                  margin: EdgeInsets.symmetric(vertical: 15),
                  color: const Color(0xFFEAEAEA),
                ),
                _buildRightButton(context),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          margin: EdgeInsets.only(left: 20),
          width: 8,
          height: heightTriangle,
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
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 15),
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
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 15),
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