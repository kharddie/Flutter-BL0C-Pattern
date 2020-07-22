import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/LoginScreen.dart';
import 'package:flutter_bloc_pattern/bloc_pattern.dart';
import 'package:flutter_bloc_pattern/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'Login': (content) => LoginScreen(),
        'bloc_pattern': (content) => BlocPattern(),
      },
      theme: ThemeData(
        fontFamily: 'Nunito',
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.black87),
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
            bodyText1: TextStyle(fontSize: 18),
            bodyText2: TextStyle(fontSize: 16),
            button: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
            headline5: TextStyle(fontWeight: FontWeight.bold),
            subtitle1: TextStyle(color: Colors.red)),
      ),
      home: HomePage(),
    );
  }
}
