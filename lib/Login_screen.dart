import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/shared/bottom_nav.dart';
import 'package:flutter_bloc_pattern/ui/custom_input_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Title(color: Colors.pink[100], child: Text("BLog In")),
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Container(
            color: Theme.of(context).primaryColor,
            width: (MediaQuery.of(context).size.width),
            height: (MediaQuery.of(context).size.height * .4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CustomInputField(
                    Icon(
                      Icons.person,
                      color: Colors.black87,
                    ),
                    "User name"),
                CustomInputField(
                    Icon(
                      Icons.lock,
                      color: Colors.black87,
                    ),
                    "Password"),
                Container(
                  width: 150,
                  height: 50,
                  child: RaisedButton(
                      onPressed: () => null,
                      color: Colors.deepOrange,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text("LogIn")),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNav(),
    );
  }
}
