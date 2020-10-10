import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/screens/bottom_tab/account/account_screen.dart';
import 'package:flutter_sample/screens/bottom_tab/home/home_screen.dart';

class BottomTabScreen extends StatefulWidget {
  static const routeName = '/bottom_tab';

  @override
  _BottomTabScreenState createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen> {
  final List<GlobalKey<NavigatorState>> _tabNavKeyList =
      List.generate(2, (index) => index)
          .map((e) => GlobalKey<NavigatorState>())
          .toList();

  final CupertinoTabController _controller = CupertinoTabController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !await _tabNavKeyList[_controller.index].currentState.maybePop();
      },
      child: CupertinoTabScaffold(
        controller: _controller,
        tabBar: CupertinoTabBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.house),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
            ),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            navigatorKey: _tabNavKeyList[index],
            builder: (BuildContext context) {
              switch (index) {
                case 0:
                  return HomeScreen();
                case 1:
                  return AccountScreen();
              }
              // error
              return Container();
            },
          );
        },
      ),
    );
  }
}
