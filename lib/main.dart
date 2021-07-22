import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simple_social_app/flows/album-screen/album_screen_cubit.dart';
import 'package:simple_social_app/flows/album-screen/album_screen_widget.dart';
import 'package:simple_social_app/flows/create-account/create_account_screen_widget.dart';
import 'package:simple_social_app/flows/home-screen/home_screen_cubit.dart';
import 'package:simple_social_app/flows/home-screen/home_screen_widget.dart';
import 'package:simple_social_app/flows/landing-page/landing_page_widget.dart';
import 'package:simple_social_app/flows/login/login_screen_widget.dart';
import 'package:simple_social_app/flows/post-screen/post_screen_widget.dart';
import 'package:simple_social_app/flows/post-screen/post_screen_cubit.dart';
import 'package:simple_social_app/flows/splash-screen/splash_screen_cubit.dart';
import 'package:simple_social_app/flows/splash-screen/splash_screen_widget.dart';
import 'package:simple_social_app/flows/user-profile-screen/user_profile_screen_cubit.dart';
import 'package:simple_social_app/flows/user-profile-screen/user_profile_screen_widget.dart';
import 'package:simple_social_app/repository/api_client.dart';
import 'package:simple_social_app/repository/api_repository.dart';

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
                      create: (context) => HomeScreenCubit(APIRepository(
                          apiClient: APIClient(httpClient: http.Client()))),
                      child: HomeScreenWidget()),
                  type: PageTransitionType.rightToLeft,
                  settings: settings);
            case '/back-to-home-screen':
              return PageTransition(
                  child: BlocProvider(
                      create: (context) => HomeScreenCubit(APIRepository(
                          apiClient: APIClient(httpClient: http.Client()))),
                      child: HomeScreenWidget()),
                  type: PageTransitionType.fade,
                  settings: settings);
            case '/post-screen':
              return PageTransition(
                  child: BlocProvider(
                      create: (context) => PostScreenCubit(APIRepository(
                          apiClient: APIClient(httpClient: http.Client()))),
                      child: PostScreenWidget()),
                  type: PageTransitionType.rightToLeft,
                  settings: settings);
            case '/user-profile':
              return PageTransition(
                  child: BlocProvider(
                      create: (context) => UserProfileScreenCubit(APIRepository(
                          apiClient: APIClient(httpClient: http.Client()))),
                      child: UserProfileScreenWidget()),
                  type: PageTransitionType.rightToLeft,
                  settings: settings);
            case '/album':
              return PageTransition(
                  child: BlocProvider(
                      create: (context) => AlbumScreenCubit(APIRepository(
                          apiClient: APIClient(httpClient: http.Client()))),
                      child: AlbumScreenWidget()),
                  type: PageTransitionType.rightToLeft,
                  settings: settings);
            default:
              return null;
          }
        });
  }
}
