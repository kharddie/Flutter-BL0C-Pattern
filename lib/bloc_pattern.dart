import 'package:flutter/material.dart';

class BlocPattern extends StatelessWidget {
  const BlocPattern({Key key}) : super(key: key);

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
