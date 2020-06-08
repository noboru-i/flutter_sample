import 'dart:math' as math;

import 'package:flutter/material.dart';

const _numberWidth = 52.0;
const _numberHeight = 78.0;
const _animationDuration = Duration(milliseconds: 1500);

class SlotScreen extends StatelessWidget {
  static const routeName = '/slot';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('slot'),
      ),
      body: _Screen(),
    );
  }
}

class _Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<_Screen> {
  List<int> result = [0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _Slot(
            result: result,
          ),
          RaisedButton(
            onPressed: () {
              final num = math.Random().nextInt(9999);
              setState(() {
                result = num.toString()
                    .split('')
                    .map((i) => int.tryParse(i) ?? 0)
                    .toList();
                print(result);
              });
            },
            child: Text('stop'),
          ),
        ],
      ),
    );
  }
}

class _Slot extends StatefulWidget {
  const _Slot({
    this.result,
  });

  final List<int> result;

  @override
  _SlotState createState() => _SlotState();
}

class _SlotState extends State<_Slot> {
  final _randomRotateFactor = (math.Random().nextInt(4) + 2);

  List<ScrollController> _controllers;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      widget.result.length,
      (_) => ScrollController(),
    ).toList();

    WidgetsBinding.instance.addPostFrameCallback((_) => _updateAll());
  }

  @override
  void didUpdateWidget(_Slot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.result == widget.result) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => _updateAll());
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.result.length;

    return Container(
      width: _numberWidth * count,
      height: _numberHeight,
      color: Colors.black26,
      child: Row(
        children: List.generate(
          count,
          (i) => _Numbers(
            controller: _controllers[i],
            count: _randomRotateFactor * 10,
            zeroToBlank: _isZeroToBlank(i),
          ),
        ).toList(),
      ),
    );
  }

  bool _isZeroToBlank(int index) {
    final numLength =
        (int.tryParse(widget.result.join()) ?? 0).toString().length;
    final columnLength = widget.result.length;
    return numLength < (columnLength - index);
  }

  void _updateAll() {
    for (var i = 0; i < widget.result.length; i++) {
      // move to last
      _controllers[i].jumpTo(
        _numberHeight * _randomRotateFactor * 10,
      );

      // animate to selected value
      _controllers[i].animateTo(
        _numberHeight * (10 - widget.result[i]),
        duration: _animationDuration * (1 - i * 0.1),
        curve: Curves.easeInOut,
      );
    }
  }
}

class _Numbers extends StatelessWidget {
  _Numbers({
    this.controller,
    this.count,
    this.zeroToBlank,
  });

  final ScrollController controller;
  final int count;
  final bool zeroToBlank;

  final offset = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _numberWidth,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        itemCount: count,
        itemBuilder: (context, index) {
          final num = (10 - index) % 10;
          return _Number(num == 0 && zeroToBlank ? null : num);
        },
      ),
    );
  }
}

class _Number extends StatelessWidget {
  const _Number(this.num);

  final int num;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _numberWidth,
      height: _numberHeight,
      alignment: Alignment.center,
      child: Text(
        num == null ? '' : '$num',
        style: TextStyle(
          fontSize: _numberHeight,
          height: 1,
          color: Colors.blue,
        ),
      ),
    );
  }
}
