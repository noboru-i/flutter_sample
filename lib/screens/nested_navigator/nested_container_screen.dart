import 'package:flutter/material.dart';
import 'package:flutter_sample/screens/nested_navigator/nested_screens.dart';
import 'package:provider/provider.dart';

class NestedContainerScreenResult {
  const NestedContainerScreenResult({
    this.isCompleted,
  });

  final bool isCompleted;
}

class NestedContainerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NestedContainerScreenState(
        onCompleted: (isCompleted) => _onCompleted(context, isCompleted),
      ),
      child: Navigator(
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
    );
  }

  Future<void> _onCompleted(BuildContext context, bool isCompleted) async {
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
  String _name;
  int _age;
  bool _sending = false;

  String get name => _name;

  int get age => _age;

  bool get sending => _sending;

  void saveName(String name) {
    _name = name;
  }

  void saveAge(int age) {
    _age = age;
  }

  Future<void> submit() async {
    _sending = true;
    notifyListeners();

    // send name and age by API.
    await Future.delayed(Duration(seconds: 3));

    _sending = false;
    notifyListeners();

    onCompleted(true);
  }
}
