import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                  return _HomePage();
                case 1:
                  return _AccountPage();
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

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('HomePage'),
            ElevatedButton(
              child: Text('move to detail'),
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute<void>(
                    builder: (context) => _HomeDetail(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeDetail'),
      ),
      body: Container(
        child: Text('HomeDetail'),
      ),
    );
  }
}

class _AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AccountPage'),
      ),
      body: Container(
        child: Text('AccountPage'),
      ),
    );
  }
}
