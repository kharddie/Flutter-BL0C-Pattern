import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/shared/bottom_nav.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Working', style: Theme.of(context).textTheme.headline5),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text("Menu",
                  style: TextStyle(color: Colors.red, fontSize: 24)),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Home'),
              onTap: () => Navigator.pushNamed(context, 'home'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Bloc Pattern'),
              onTap: () => Navigator.pushNamed(context, 'bloc_pattern'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(),
    );
  }
}
