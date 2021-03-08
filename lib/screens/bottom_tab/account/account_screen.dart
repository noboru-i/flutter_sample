import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AccountPage'),
      ),
      body: Container(
        child: const Text('AccountPage'),
      ),
    );
  }
}
