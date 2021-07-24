import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreenWidget extends StatelessWidget {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

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
                controller: emailController,
                decoration: InputDecoration(labelText: "Email address"),
              )),
          Container(
            height: _height * 0.05,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
              )),
          Container(
            height: _height * 0.05,
          ),
          Container(
            child: TextButton(
              onPressed: () {
                if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(emailController.text)) {
                  Alert(
                      context: context,
                      title: "Invalid Email",
                      desc: "Your email appears to be of invalid format")
                      .show();
                } else if (passwordController.text.length < 4) {
                  Alert(
                      context: context,
                      title: "Password Too Short",
                      desc:
                      "Your password needs to be at least 4 characters")
                      .show();
                }  else {
                  Navigator.pushNamed(context, '/home-screen');
                }
              },
              child: Text("Log In"),
            ),
          ),
        ],
      ),
    );
  }
}
