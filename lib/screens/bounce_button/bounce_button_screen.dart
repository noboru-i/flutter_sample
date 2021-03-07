import 'package:flutter/material.dart';
import 'package:flutter_sample/screens/bounce_button/bounce_button.dart';

class BounceButtonScreen extends StatelessWidget {
  static const routeName = '/bounce_button';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            const Text('Large'),
            _ListItem0(),
            const Text('enabled'),
            _ListItem1(),
            const Text('disabled'),
            _ListItem2(),
            const Text('onLongPress'),
            _ListItem3(),
            const Text('enable colors'),
            const _ListItem5(isEnabled: true),
            const Text('disabled color'),
            const _ListItem5(isEnabled: false),
            const Text('Brightness.light'),
            const _ListItem7(Brightness.light),
            const Text('Brightness.dark'),
            const _ListItem7(Brightness.dark),
            const Text('elevation'),
            _ListItem8(),
            const Text('padding'),
            _ListItem9(),
            const Text('shape'),
            _ListItem10(),
            const Text('ratio'),
            _ListItem11(),
          ],
        ),
      ),
    );
  }
}

class _ListItem0 extends StatelessWidget {
  void _onPressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('pressed!'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      constraints: const BoxConstraints.expand(height: 150),
      child: BounceButton(
        onPressed: () => _onPressed(context),
        child: const Text('BounceButton'),
      ),
    );
  }
}

class _ListItem1 extends StatelessWidget {
  void _onPressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('pressed!'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ElevatedButton(
          onPressed: () => _onPressed(context),
          child: const Text('ElevatedButton'),
        ),
        TextButton(
          onPressed: () => _onPressed(context),
          child: const Text('TextButton'),
        ),
        BounceButton(
          onPressed: () => _onPressed(context),
          child: const Text('BounceButton'),
        ),
      ],
    );
  }
}

class _ListItem2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const <Widget>[
        ElevatedButton(
          onPressed: null,
          child: Text('ElevatedButton'),
        ),
        TextButton(
          onPressed: null,
          child: Text('TextButton'),
        ),
        BounceButton(
          onPressed: null,
          child: Text('BounceButton'),
        ),
      ],
    );
  }
}

class _ListItem3 extends StatelessWidget {
  void _onLongPressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('long pressed!'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ElevatedButton(
          onPressed: null,
          onLongPress: () => _onLongPressed(context),
          child: const Text('ElevatedButton'),
        ),
        TextButton(
          onPressed: null,
          onLongPress: () => _onLongPressed(context),
          child: const Text('TextButton'),
        ),
        BounceButton(
          onPressed: null,
          onLongPress: () => _onLongPressed(context),
          child: const Text('BounceButton'),
        ),
      ],
    );
  }
}

class _ListItem5 extends StatelessWidget {
  const _ListItem5({
    this.isEnabled,
  });

  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ElevatedButton(
          onPressed: isEnabled ? () {} : null,
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            onPrimary: Colors.yellow,
            onSurface: Colors.amber,
          ),
          child: const Text('ElevatedButton'),
        ),
        TextButton(
          onPressed: isEnabled ? () {} : null,
          style: TextButton.styleFrom(
            primary: Colors.yellow,
            onSurface: Colors.amber,
          ),
          child: const Text('TextButton'),
        ),
        BounceButton(
          onPressed: isEnabled ? () {} : null,
          textColor: Colors.yellow,
          color: Colors.green,
          disabledTextColor: Colors.amber,
          disabledColor: Colors.cyan,
          child: const Text('BounceButton'),
        ),
      ],
    );
  }
}

class _ListItem7 extends StatelessWidget {
  const _ListItem7(this.colorBrightness);

  final Brightness colorBrightness;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        BounceButton(
          onPressed: () {},
          colorBrightness: colorBrightness,
          child: const Text('BounceButton'),
        ),
      ],
    );
  }
}

class _ListItem8 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 8,
          ),
          child: const Text('ElevatedButton'),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            elevation: 8,
          ),
          child: const Text('TextButton'),
        ),
        BounceButton(
          onPressed: () {},
          elevation: 8,
          child: const Text('BounceButton'),
        ),
      ],
    );
  }
}

class _ListItem9 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 24),
          ),
          child: const Text('ElevatedButton'),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 24),
          ),
          child: const Text('TextButton'),
        ),
        BounceButton(
          onPressed: () {},
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: const Text('BounceButton'),
        ),
      ],
    );
  }
}

class _ListItem10 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
          ),
          child: const Text('ElevatedButton'),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            shape: const StadiumBorder(),
          ),
          child: const Text('TextButton'),
        ),
        BounceButton(
          onPressed: () {},
          shape: const StadiumBorder(),
          child: const Text('BounceButton'),
        ),
      ],
    );
  }
}

class _ListItem11 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BounceButton(
            onPressed: () {},
            child: const Text('BounceButton\nunspecified'),
          ),
          BounceButton(
            onPressed: () {},
            ratio: 0.5,
            child: const Text('BounceButton\n0.5'),
          ),
          BounceButton(
            onPressed: () {},
            ratio: 1.5,
            child: const Text('BounceButton\n1.5'),
          ),
        ],
      ),
    );
  }
}
