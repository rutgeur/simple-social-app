import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simple_social_app/flows/create-account/create_account_screen_widget.dart';
import 'package:simple_social_app/flows/home-screen/home_screen_cubit.dart';
import 'package:simple_social_app/flows/home-screen/home_screen_widget.dart';
import 'package:simple_social_app/flows/landing-page/landing_page_widget.dart';
import 'package:simple_social_app/flows/login/login_screen_widget.dart';
import 'package:simple_social_app/flows/splash-screen/splash_screen_cubit.dart';
import 'package:simple_social_app/flows/splash-screen/splash_screen_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash-screen',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/splash-screen':
              return PageTransition(
                  child: BlocProvider(
                    create: (context) => SplashScreenCubit(),
                    child: SplashScreenWidget(),
                  ),
                  type: PageTransitionType.rightToLeft,
                  settings: settings);
            case '/landing-page':
              return PageTransition(
                  child: LandingPageWidget(),
                  type: PageTransitionType.rightToLeft,
                  settings: settings);
            case '/create-account':
              return PageTransition(
                  child: CreateAccountScreenWidget(),
                  type: PageTransitionType.rightToLeft,
                  settings: settings);
            case '/login':
              return PageTransition(
                  child: LoginScreenWidget(),
                  type: PageTransitionType.rightToLeft,
                  settings: settings);
            case '/home-screen':
              return PageTransition(
                  child: BlocProvider(
                      create: (context) => HomeScreenCubit(),
                      child: HomeScreenWidget()),
                  type: PageTransitionType.rightToLeft,
                  settings: settings);
            default:
              return null;
          }
        });
  }
}
