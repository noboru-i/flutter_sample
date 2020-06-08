import 'package:flutter/material.dart';
import 'package:flutter_sample/screens/bounce_button/bounce_button_screen.dart';
import 'package:flutter_sample/screens/half_circle_button/half_circle_button_screen.dart';
import 'package:flutter_sample/screens/hover/hover_screen.dart';
import 'package:flutter_sample/screens/rotate_background/rotate_background_screen.dart';
import 'package:flutter_sample/screens/slot/slot_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        BounceButtonScreen.routeName: (context) => BounceButtonScreen(),
        HalfCircleButtonScreen.routeName: (context) => HalfCircleButtonScreen(),
        RotateBackgroundScreen.routeName: (context) => RotateBackgroundScreen(),
        HoverScreen.routeName: (context) => HoverScreen(),
        SlotScreen.routeName: (context) => SlotScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  final screens = [
    BounceButtonScreen.routeName,
    HalfCircleButtonScreen.routeName,
    RotateBackgroundScreen.routeName,
    HoverScreen.routeName,
    SlotScreen.routeName,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: screens.length,
          itemBuilder: (
            BuildContext context,
            int index,
          ) {
            final name = screens[index];
            return Card(
              child: ListTile(
                title: Text(name),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pushNamed(context, name);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
