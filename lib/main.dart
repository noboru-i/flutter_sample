import 'package:flutter/material.dart';
import 'package:flutter_sample/screens/bottom_tab/bottom_tab_screen.dart';
import 'package:flutter_sample/screens/bounce_button/bounce_button_screen.dart';
import 'package:flutter_sample/screens/file_picker/file_picker_screen.dart';
import 'package:flutter_sample/screens/half_circle_button/half_circle_button_screen.dart';
import 'package:flutter_sample/screens/hover/hover_screen.dart';
import 'package:flutter_sample/screens/rotate_background/rotate_background_screen.dart';
import 'package:flutter_sample/screens/slot/slot_screen.dart';
import 'package:flutter_sample/screens/tap_down/tap_down_screen.dart';

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
        BottomTabScreen.routeName: (context) => BottomTabScreen(),
        BounceButtonScreen.routeName: (context) => BounceButtonScreen(),
        FilePickerScreen.routeName: (context) => FilePickerScreen(),
        HalfCircleButtonScreen.routeName: (context) => HalfCircleButtonScreen(),
        HoverScreen.routeName: (context) => HoverScreen(),
        RotateBackgroundScreen.routeName: (context) => RotateBackgroundScreen(),
        SlotScreen.routeName: (context) => SlotScreen(),
        TapDownScreen.routeName: (context) => TapDownScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  final screens = [
    BottomTabScreen.routeName,
    BounceButtonScreen.routeName,
    FilePickerScreen.routeName,
    HalfCircleButtonScreen.routeName,
    HoverScreen.routeName,
    RotateBackgroundScreen.routeName,
    SlotScreen.routeName,
    TapDownScreen.routeName,
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
