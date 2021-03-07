import 'package:flutter/material.dart';
import 'package:flutter_sample/screens/nested_navigator/nested_container_screen.dart';

class NestedFirstScreen extends StatelessWidget {
  static const routeName = '/nested_navigator_first';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Before nested screens'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showNextScreen(context),
          child: const Text('Start nested navigation'),
        ),
      ),
    );
  }

  Future<void> _showNextScreen(BuildContext context) async {
    final result =
        await Navigator.of(context).push<NestedContainerScreenResult>(
      MaterialPageRoute(
        builder: (context) => NestedContainerScreen(),
      ),
    );

    if (result?.isCompleted == true) {
      // show dialog when navigation is completed.
      await showDialog<void>(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: const Text('Completed!'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
