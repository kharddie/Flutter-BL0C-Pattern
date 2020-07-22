import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

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
      bottomNavigationBar: BottomNavigationBar(items: null),
    );
  }
}
