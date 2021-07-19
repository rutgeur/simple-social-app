part of 'home_screen_cubit.dart';

@immutable
abstract class HomeScreenState {}

class HomeScreenInitial extends HomeScreenState {}

class Loading extends HomeScreenState {}

class LoadedData extends HomeScreenState {}

class Error extends HomeScreenState {}

class LoggedOut extends HomeScreenState {}