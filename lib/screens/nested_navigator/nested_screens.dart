import 'package:flutter/material.dart';
import 'package:flutter_sample/screens/nested_navigator/nested_container_screen.dart';
import 'package:provider/provider.dart';

class NestedScreen1 extends StatefulWidget {
  static const routeName = 'nested/nested1';

  @override
  _NestedScreen1State createState() => _NestedScreen1State();
}

class _NestedScreen1State extends State<NestedScreen1> {
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NestedScreen1'),
        leading: BackButton(
          onPressed: () => _onBack(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'e.g. Tom',
                labelText: 'Name',
              ),
              controller: _controller,
            ),
            RaisedButton(
              child: Text('Next'),
              onPressed: () => _showNextScreen(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onBack(BuildContext context) async {
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future<void> _showNextScreen(BuildContext context) async {
    context.read<NestedContainerScreenState>().saveName(_controller.text);
    Navigator.of(context).pushNamed(NestedScreen2.routeName);
  }
}

class NestedScreen2 extends StatefulWidget {
  static const routeName = 'nested/nested2';

  @override
  _NestedScreen2State createState() => _NestedScreen2State();
}

class _NestedScreen2State extends State<NestedScreen2> {
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NestedScreen2'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'e.g. 20',
                labelText: 'Age',
              ),
              controller: _controller,
            ),
            RaisedButton(
              child: Text('Next'),
              onPressed: () => _showNextScreen(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showNextScreen(BuildContext context) async {
    final age = int.tryParse(_controller.text);
    context.read<NestedContainerScreenState>().saveAge(age);
    Navigator.of(context).pushNamed(NestedConfirmScreen.routeName);
  }
}

class NestedConfirmScreen extends StatelessWidget {
  static const routeName = 'nested/nested_confirm';

  @override
  Widget build(BuildContext context) {
    final name = context.watch<NestedContainerScreenState>().name;
    final age = context.watch<NestedContainerScreenState>().age;
    final sending =
        context.watch<NestedContainerScreenState>().sending ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text('NestedConfirmScreen'),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Text('Name: $name'),
                Text('Age: ${age ?? ''}'),
                RaisedButton(
                  child: Text('Submit'),
                  onPressed: () => _submit(context),
                ),
              ],
            ),
          ),
          Visibility(
            visible: sending,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    context.read<NestedContainerScreenState>().submit();
  }
}
