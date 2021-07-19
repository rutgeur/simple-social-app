import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateAccountScreenWidget extends StatelessWidget {
  const CreateAccountScreenWidget();

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Container(
            height: _height * 0.1,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: TextField(
                decoration: InputDecoration(labelText: "Email address"),
              )),
          Container(
            height: _height * 0.05,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
              )),
          Container(
            height: _height * 0.05,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(labelText: "Confirm Password"),
              )),
          Container(
            height: _height * 0.05,
          ),
          Container(
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home-screen');
              },
              child: Text("Log In"),
            ),
          ),
        ],
      ),
    );
  }
}
