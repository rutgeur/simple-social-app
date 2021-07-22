part of 'home_screen_cubit.dart';

@immutable
abstract class HomeScreenState {
}

class HomeScreenInitial extends HomeScreenState {}

class Loading extends HomeScreenState {}

class LoadedData extends HomeScreenState {
  final User user;
  final List<Post> posts;

  LoadedData(this.user, this.posts);
}

class Error extends HomeScreenState {}

class LoggedOut extends HomeScreenState {}