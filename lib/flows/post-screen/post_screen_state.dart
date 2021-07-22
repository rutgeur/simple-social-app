part of 'post_screen_cubit.dart';

@immutable
abstract class PostScreenState {}

class PostScreenInitial extends PostScreenState {}

class Loading extends PostScreenState {}

class LoadedData extends PostScreenState {
  final List<Comment> comments;

  LoadedData(this.comments);
}

class Error extends PostScreenState {}

class LoggedOut extends PostScreenState {}