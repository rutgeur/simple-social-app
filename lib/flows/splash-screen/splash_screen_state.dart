part of 'splash_screen_cubit.dart';

@immutable
abstract class SplashScreenState {}

class SplashScreenInitial extends SplashScreenState {}

class LoggedIn extends SplashScreenState {}

class NotLoggedIn extends SplashScreenState {}

class Error extends SplashScreenState {}
