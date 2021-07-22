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

  Future<void> retrieveData(User user) async {
    emit(Loading());
    try {
      final posts = await _apiRepository.getPostsForUser(user.id.toString());
      final albums = await _apiRepository.getAlbumsForUser(user.id.toString());
      emit(LoadedData(posts, albums));
    } catch (APIError) {
      emit(Error());
    }
  }
}
