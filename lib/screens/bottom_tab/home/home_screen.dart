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
              title: const Text('HomePage'),
            ),
            body: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('HomePage'),
                    ElevatedButton(
                      onPressed: () => _refresh(context),
                      child: const Text('refresh'),
                    ),
                    ElevatedButton(
                      onPressed: () => _moveToDetail(context),
                      child: const Text('move to detail'),
                    ),
                    Expanded(
                      child: _List(),
                    ),
                  ],
                ),
                Visibility(
                  visible: context.select((HomeState state) => state.isLoading),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> _refresh(BuildContext context) async {
    await context.read<HomeStateNotifier>().refresh();
  }

  Future<void> _moveToDetail(BuildContext context) async {
    await Navigator.of(context).push(
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
          padding: const EdgeInsets.all(8),
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
        title: const Text('HomeDetail'),
      ),
      body: Container(
        child: const Text('HomeDetail'),
      ),
    );
  }
}
