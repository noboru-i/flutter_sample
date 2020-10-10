import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/screens/bottom_tab/home/home_state.dart';
import 'package:flutter_sample/screens/bottom_tab/home/home_state_notifier.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<HomeStateNotifier, HomeState>(
        create: (_) => HomeStateNotifier(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text('HomePage'),
            ),
            body: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('HomePage'),
                    ElevatedButton(
                      child: Text('refresh'),
                      onPressed: () => _refresh(context),
                    ),
                    ElevatedButton(
                      child: Text('move to detail'),
                      onPressed: () => _moveToDetail(context),
                    ),
                    Expanded(
                      child: _List(),
                    ),
                  ],
                ),
                Visibility(
                  visible: context.select((HomeState state) => state.isLoading),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> _refresh(BuildContext context) async {
    context.read<HomeStateNotifier>().refresh();
  }

  Future<void> _moveToDetail(BuildContext context) async {
    Navigator.of(context).push(
      CupertinoPageRoute<void>(
        builder: (context) => _HomeDetailScreen(),
      ),
    );
  }
}

class _List extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final list = context.select((HomeState state) => state.list);
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => Card(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Text(list[index]),
        ),
      ),
    );
  }
}

class _HomeDetailScreen extends StatelessWidget {
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
