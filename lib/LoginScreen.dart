import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/shared/bottom_nav.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Title(color: Colors.pink[100], child: Text("Block pattern")),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("data"),
            Text("data"),
            Text("data"),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(),
    );
  }
}
