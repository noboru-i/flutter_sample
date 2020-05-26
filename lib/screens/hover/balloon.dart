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
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
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
      _removeEntry();
      return;
    }

    print('tap PlaybackBalloon');
    _createNewEntry();
    _controller.forward();
  }

  void _removeEntry() {
    _entry.remove();
    _entry = null;
  }

  void _createNewEntry() {
    final box = context.findRenderObject() as RenderBox;
    final target = box.localToGlobal(box.size.center(Offset.zero));

    final Widget overlay = _BalloonOverlay(
      animation: CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
      target: target,
    );
    _entry = OverlayEntry(builder: (BuildContext context) => overlay);
    Overlay.of(context, debugRequiredFor: widget).insert(_entry);
  }
}

// inspired by Tooltip in material/tooltip.dart.
class _BalloonOverlay extends StatelessWidget {
  const _BalloonOverlay({
    this.animation,
    this.target,
  });

  final Animation<double> animation;
  final Offset target;

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );
    const padding = EdgeInsets.symmetric(horizontal: 16.0);
    final textStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 14,
        );

    return Positioned.fill(
      child: IgnorePointer(
        child: CustomSingleChildLayout(
          delegate: _TooltipPositionDelegate(
            target: target,
          ),
          child: FadeTransition(
            opacity: animation,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 52,
              ),
              child: Container(
                decoration: decoration,
                padding: padding,
                child: Center(
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Sample1',
                        style: textStyle,
                      ),
                      const SizedBox(width: 13),
                      Container(
                        width: 1,
                        height: 23,
                        color: const Color(0xFFEAEAEA),
                      ),
                      const SizedBox(width: 13),
                      Text(
                        'Sample2',
                        style: textStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// inspired by _TooltipPositionDelegate from material/tooltip.dart.
class _TooltipPositionDelegate extends SingleChildLayoutDelegate {
  _TooltipPositionDelegate({
    @required this.target,
  });

  final Offset target;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      constraints.loosen();

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    print('target $target');
    print('childSize $childSize');
    return positionDependentBox(
      size: size,
      childSize: childSize,
      target: target,
      verticalOffset: childSize.height,
      preferBelow: false,
    );
  }

  @override
  bool shouldRelayout(_TooltipPositionDelegate oldDelegate) {
    return target != oldDelegate.target;
  }
}
