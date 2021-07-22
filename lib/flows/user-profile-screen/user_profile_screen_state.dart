part of 'user_profile_screen_cubit.dart';

@immutable
abstract class UserProfileScreenState {}

class UserProfileScreenInitial extends UserProfileScreenState {}

class Loading extends UserProfileScreenState {}

class LoadedData extends UserProfileScreenState {
  final List<Post> posts;
  final List<Album> albums;

  LoadedData(this.posts, this.albums);
}

class Error extends UserProfileScreenState {}

class LoggedOut extends UserProfileScreenState {}