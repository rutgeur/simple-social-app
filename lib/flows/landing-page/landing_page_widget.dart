import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingPageWidget extends StatelessWidget {
  const LandingPageWidget();

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Column(
            children: [
              Container(
                height: _height * 0.4,
              ),
              Container(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/create-account');
                  },
                  child: Text("Create Account"),
                ),
              ),
              Container(
                height: _height * 0.05,
              ),
              Container(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text("Login"),
                ),
              ),
            ],
          ),
        ));
  }
}
