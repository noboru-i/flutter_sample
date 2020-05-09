import 'package:flutter/material.dart';
import 'package:flutter_sample/screens/bounce_button/bounce_button.dart';

class BounceButtonScreen extends StatelessWidget {
  static const routeName = '/bounce_button';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Text('Large'),
            _ListItem0(),
            Text('enabled'),
            _ListItem1(),
            Text('disabled'),
            _ListItem2(),
            Text('onLongPress'),
            _ListItem3(),
            Text('ButtonTextTheme.normal'),
            _ListItem4(ButtonTextTheme.normal),
            Text('ButtonTextTheme.accent'),
            _ListItem4(ButtonTextTheme.accent),
            Text('ButtonTextTheme.primary'),
            _ListItem4(ButtonTextTheme.primary),
            Text('enable colors'),
            _ListItem5(),
            Text('disabled color'),
            _ListItem6(),
            Text('Brightness.light'),
            _ListItem7(Brightness.light),
            Text('Brightness.dark'),
            _ListItem7(Brightness.dark),
            Text('elevation'),
            _ListItem8(),
            Text('padding'),
            _ListItem9(),
            Text('shape'),
            _ListItem10(),
            Text('ratio'),
            _ListItem11(),
          ],
        ),
      ),
    );
  }
}

class _ListItem0 extends StatelessWidget {
  void _onPressed(BuildContext context) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text('pressed!'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      constraints: BoxConstraints.expand(height: 150),
      child: BounceButton(
        onPressed: () => _onPressed(context),
        child: Text('BounceButton'),
      ),
    );
  }
}

class _ListItem1 extends StatelessWidget {
  void _onPressed(BuildContext context) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text('pressed!'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RaisedButton(
          onPressed: () => _onPressed(context),
          child: Text('RaisedButton'),
        ),
        FlatButton(
          onPressed: () => _onPressed(context),
          child: Text('FlatButton'),
        ),
        BounceButton(
          onPressed: () => _onPressed(context),
          child: Text('BounceButton'),
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
      children: <Widget>[
        RaisedButton(
          onPressed: null,
          child: Text('RaisedButton'),
        ),
        FlatButton(
          onPressed: null,
          child: Text('FlatButton'),
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
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text('long pressed!'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RaisedButton(
          onPressed: null,
          onLongPress: () => _onLongPressed(context),
          child: Text('RaisedButton'),
        ),
        FlatButton(
          onPressed: null,
          onLongPress: () => _onLongPressed(context),
          child: Text('FlatButton'),
        ),
        BounceButton(
          onPressed: null,
          onLongPress: () => _onLongPressed(context),
          child: Text('BounceButton'),
        ),
      ],
    );
  }
}

class _ListItem4 extends StatelessWidget {
  _ListItem4(this.textTheme);

  ButtonTextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RaisedButton(
          onPressed: () {},
          textTheme: textTheme,
          child: Text('RaisedButton'),
        ),
        FlatButton(
          onPressed: () {},
          textTheme: textTheme,
          child: Text('FlatButton'),
        ),
        BounceButton(
          onPressed: () {},
          textTheme: textTheme,
          child: Text('BounceButton'),
        ),
      ],
    );
  }
}

class _ListItem5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RaisedButton(
          onPressed: () {},
          textColor: Colors.yellow,
          color: Colors.green,
          child: Text('RaisedButton'),
        ),
        FlatButton(
          onPressed: () {},
          textColor: Colors.yellow,
          color: Colors.green,
          child: Text('FlatButton'),
        ),
        BounceButton(
          onPressed: () {},
          textColor: Colors.yellow,
          color: Colors.green,
          child: Text('BounceButton'),
        ),
      ],
    );
  }
}

class _ListItem6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RaisedButton(
          onPressed: null,
          disabledTextColor: Colors.amber,
          disabledColor: Colors.cyan,
          child: Text('RaisedButton'),
        ),
        FlatButton(
          onPressed: null,
          disabledTextColor: Colors.amber,
          disabledColor: Colors.cyan,
          child: Text('FlatButton'),
        ),
        BounceButton(
          onPressed: null,
          disabledTextColor: Colors.amber,
          disabledColor: Colors.cyan,
          child: Text('BounceButton'),
        ),
      ],
    );
  }
}

class _ListItem7 extends StatelessWidget {
  _ListItem7(this.colorBrightness);

  Brightness colorBrightness;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RaisedButton(
          onPressed: () {},
          colorBrightness: colorBrightness,
          child: Text('RaisedButton'),
        ),
        FlatButton(
          onPressed: () {},
          colorBrightness: colorBrightness,
          child: Text('FlatButton'),
        ),
        BounceButton(
          onPressed: () {},
          colorBrightness: colorBrightness,
          child: Text('BounceButton'),
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
        RaisedButton(
          onPressed: () {},
          elevation: 8,
          child: Text('RaisedButton'),
        ),
        FlatButton(
          onPressed: () {},
//          elevation: 8,
          child: Text('FlatButton'),
        ),
        BounceButton(
          onPressed: () {},
          elevation: 8,
          child: Text('BounceButton'),
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
        RaisedButton(
          onPressed: () {},
          padding: EdgeInsets.symmetric(vertical: 24.0),
          child: Text('RaisedButton'),
        ),
        FlatButton(
          onPressed: () {},
          padding: EdgeInsets.symmetric(vertical: 24.0),
          child: Text('FlatButton'),
        ),
        BounceButton(
          onPressed: () {},
          padding: EdgeInsets.symmetric(vertical: 24.0),
          child: Text('BounceButton'),
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
        RaisedButton(
          onPressed: () {},
          shape: StadiumBorder(),
          child: Text('RaisedButton'),
        ),
        FlatButton(
          onPressed: () {},
          shape: StadiumBorder(),
          child: Text('FlatButton'),
        ),
        BounceButton(
          onPressed: () {},
          shape: StadiumBorder(),
          child: Text('BounceButton'),
        ),
      ],
    );
  }
}

class _ListItem11 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        BounceButton(
          onPressed: () {},
          child: Text('BounceButton\nunspecified'),
        ),
        BounceButton(
          onPressed: () {},
          ratio: 0.5,
          child: Text('BounceButton\n0.5'),
        ),
        BounceButton(
          onPressed: () {},
          ratio: 1.5,
          child: Text('BounceButton\n1.5'),
        ),
      ],
    );
  }
}
