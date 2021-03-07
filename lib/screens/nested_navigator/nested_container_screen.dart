import 'package:flutter/material.dart';
import 'package:flutter_sample/screens/nested_navigator/nested_screens.dart';
import 'package:provider/provider.dart';

class NestedContainerScreenResult {
  const NestedContainerScreenResult({
    this.isCompleted,
  });

  final bool isCompleted;
}

class NestedContainerScreen extends StatefulWidget {
  @override
  _NestedContainerScreenState createState() => _NestedContainerScreenState();
}

class _NestedContainerScreenState extends State<NestedContainerScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NestedContainerScreenState(
        onCompleted: (isCompleted) => _onCompleted(context, isCompleted),
      ),
      child: WillPopScope(
        onWillPop: () async => !(await _navigatorKey.currentState.maybePop()),
        child: Navigator(
          key: _navigatorKey,
          initialRoute: NestedScreen1.routeName,
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case NestedScreen1.routeName:
                builder = (BuildContext context) => NestedScreen1();
                break;
              case NestedScreen2.routeName:
                builder = (BuildContext context) => NestedScreen2();
                break;
              case NestedConfirmScreen.routeName:
                builder = (BuildContext context) => NestedConfirmScreen();
                break;
            }
            return MaterialPageRoute<dynamic>(
              builder: builder,
              settings: settings,
            );
          },
        ),
      ),
    );
  }

  Future<void> _onCompleted(BuildContext context, bool isCompleted) async {
    await showDialog<void>(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: const Text('Thank you!'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    Navigator.of(context).pop(NestedContainerScreenResult(
      isCompleted: isCompleted,
    ));
  }
}

class NestedContainerScreenState extends ChangeNotifier {
  NestedContainerScreenState({
    this.onCompleted,
  });

  final void Function(bool) onCompleted;

  // hold all answers in this class.
  String name;
  int age;
  bool _sending = false;

  bool get sending => _sending;

  Future<void> submit() async {
    _sending = true;
    notifyListeners();

    // send name and age by API.
    await Future<void>.delayed(const Duration(seconds: 3));

    _sending = false;
    notifyListeners();

    onCompleted(true);
  }
}
