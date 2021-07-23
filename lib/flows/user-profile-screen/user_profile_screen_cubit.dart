import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_social_app/models/album.dart';
import 'package:simple_social_app/models/post.dart';
import 'package:simple_social_app/models/user.dart';
import 'package:simple_social_app/repository/api_repository.dart';

part 'user_profile_screen_state.dart';

class UserProfileScreenCubit extends Cubit<UserProfileScreenState> {
  final APIRepository _apiRepository;

  UserProfileScreenCubit(this._apiRepository) : super(UserProfileScreenInitial());

  Future<void> retrieveData(User? user, int? userID) async {
    emit(Loading());
    try {
      if (user != null) {
        final posts = await _apiRepository.getPostsForUser(user.id.toString());
        final albums = await _apiRepository.getAlbumsForUser(user.id.toString());
        emit(LoadedData(user, posts, albums));
      }
      if (userID != null) {
        final user = await _apiRepository.getUser(userID.toString());
        final posts = await _apiRepository.getPostsForUser(userID.toString());
        final albums = await _apiRepository.getAlbumsForUser(userID.toString());
        emit(LoadedData(user, posts, albums));
      }
    } catch (APIError) {
      emit(Error());
    }
  }

  Future<void> deletePost(User user, Post post) async {
    emit(Loading());
    try {
      await _apiRepository.deletePost(post.id.toString());
      retrieveData(user, null);
    } catch (APIError) {
      emit(Error());
    }
  }
}
