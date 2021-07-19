import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:simple_social_app/flows/splash-screen/splash_screen_cubit.dart';

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget();

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    return BlocConsumer<SplashScreenCubit, SplashScreenState>(
        listener: (context, state) {
      if (state is NotLoggedIn) {
        Navigator.pushNamed(context, '/landing-page');
      }
      if (state is LoggedIn) {
        Navigator.pushNamed(context, '/home-screen');
      }
      if (state is Error) {
        Alert(
                context: context,
                title: "Error",
                desc: "Something went wrong check logged in state")
            .show();
      }
    }, builder: (context, state) {
      if (state is SplashScreenInitial) {
        context.read<SplashScreenCubit>().checkIfLoggedIn();
      }
      return Scaffold(
        body: Column(
          children: [
            Container(
              height: _height * 0.2,
            ),
            Container(
              height: _height * 0.05,
              child: Text("Loading"),
            ),
          ],
        ),
      );
    });
  }
}
