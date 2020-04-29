import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RotateBackgroundScreen extends StatelessWidget {
  static const routeName = '/svg_viewer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rotate background'),
      ),
      body: Stack(
        children: <Widget>[
          _RotateBackground(),
          _Screen(),
        ],
      ),
    );
  }
}

class _RotateBackground extends StatefulWidget {
  @override
  _RotateBackgroundState createState() => _RotateBackgroundState();
}

class _RotateBackgroundState extends State<_RotateBackground>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _turns;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _turns = _animationController
        .drive(
          CurveTween(curve: Curves.linear),
        )
        .drive(
          Tween<double>(begin: 0, end: 1),
        );

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return ClipRect(
      child: OverflowBox(
        minWidth: 0.0,
        minHeight: 0.0,
        maxWidth: screenHeight,
        maxHeight: screenHeight,
        child: RotationTransition(
          turns: _turns,
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/bg.svg',
            width: screenHeight,
            height: screenHeight,
          ),
        ),
      ),
    );
  }
}

class _Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: Text(
          'rotate background',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .display3
              .copyWith(color: Colors.green),
        ),
      ),
    );
  }
}
