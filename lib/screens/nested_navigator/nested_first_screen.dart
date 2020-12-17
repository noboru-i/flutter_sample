import 'package:flutter/material.dart';
import 'package:flutter_sample/screens/nested_navigator/nested_container_screen.dart';

class NestedFirstScreen extends StatelessWidget {
  static const routeName = '/nested_navigator_first';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Before nested screens'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Start nested navigation'),
          onPressed: () => _showNextScreen(context),
        ),
      ),
    );
  }

  Future<void> _showNextScreen(BuildContext context) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NestedContainerScreen(),
      ),
    ) as NestedContainerScreenResult;

    if (result?.isCompleted == true) {
      // show dialog when navigation is completed.
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text('Thank you!'),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }
  }
}
