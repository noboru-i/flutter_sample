import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/screens/bottom_tab/account/account_screen.dart';
import 'package:flutter_sample/screens/bottom_tab/bottom_tab_state.dart';
import 'package:flutter_sample/screens/bottom_tab/bottom_tab_state_notifier.dart';
import 'package:flutter_sample/screens/bottom_tab/home/home_screen.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

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
  int _oldIndex = 0;

  final _tabTypes = [
    TabItem.home,
    TabItem.account,
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<BottomTabStateNotifier, BottomTabState>(
      create: (_) => BottomTabStateNotifier(),
      builder: (context, snapshot) {
        return WillPopScope(
          onWillPop: () async {
            return !await _tabNavKeyList[_controller.index]
                .currentState
                .maybePop();
          },
          child: CupertinoTabScaffold(
            controller: _controller,
            tabBar: CupertinoTabBar(
              onTap: (index) => _onTapItem(context, index),
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
      },
    );
  }

  void _onTapItem(BuildContext context, int index) {
    print('_onTapItem index $index');
    print('oldIndex $_oldIndex');

    if (index != _oldIndex) {
      _oldIndex = index;
      return;
    }

    final canPop = _tabNavKeyList[_controller.index].currentState.canPop();
    if (canPop) {
      _tabNavKeyList[_controller.index]
          .currentState
          .popUntil((route) => route.isFirst);
    } else {
      context.read<BottomTabStateNotifier>().notifyRefresh(_tabTypes[index]);
    }
  }
}
