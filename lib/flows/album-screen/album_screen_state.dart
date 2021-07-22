part of 'album_screen_cubit.dart';

@immutable
abstract class AlbumScreenState {}

class AlbumScreenInitial extends AlbumScreenState {}

class Loading extends AlbumScreenState {}

class LoadedData extends AlbumScreenState {
  final List<Photo> photos;

  LoadedData(this.photos);
}

class Error extends AlbumScreenState {}

class LoggedOut extends AlbumScreenState {}