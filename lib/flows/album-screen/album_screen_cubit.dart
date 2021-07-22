import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'album_screen_state.dart';

class AlbumScreenCubit extends Cubit<AlbumScreenState> {
  AlbumScreenCubit() : super(AlbumScreenInitial());
}
