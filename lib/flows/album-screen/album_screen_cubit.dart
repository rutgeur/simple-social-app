import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_social_app/models/album.dart';
import 'package:simple_social_app/models/photo.dart';
import 'package:simple_social_app/repository/api_repository.dart';

part 'album_screen_state.dart';

class AlbumScreenCubit extends Cubit<AlbumScreenState> {
  final APIRepository _apiRepository;

  AlbumScreenCubit(this._apiRepository) : super(AlbumScreenInitial());

  Future<void> retrieveData(Album album) async {
    emit(Loading());
    try {
      final photos = await _apiRepository.getPhotosForAlbum(album.id.toString());
      emit(LoadedData(photos));
    } catch (APIError) {
      emit(Error());
    }
  }
}
