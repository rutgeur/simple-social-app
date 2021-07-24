import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_social_app/helpers/constants.dart';
import 'package:simple_social_app/models/post.dart';
import 'package:simple_social_app/models/user.dart';
import 'package:simple_social_app/repository/api_repository.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  final APIRepository _apiRepository;

  HomeScreenCubit(this._apiRepository) : super(HomeScreenInitial());

  Future<void> logInAndRetrieveData() async {
    emit(Loading());
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(LOGGED_IN_KEY, true);
    try {
      final user = await _apiRepository.getUserSelf();
      final posts = await _apiRepository.getPosts();
      emit(LoadedData(user, posts));
    } catch (APIError) {
      emit(Error());
    }
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(LOGGED_IN_KEY, false);
    emit(LoggedOut());
  }

  Future<void> deletePost(Post post) async {
    emit(Loading());
    try {
      await _apiRepository.deletePost(post.id.toString());
      logInAndRetrieveData();
    } catch (APIError) {
      emit(Error());
    }
  }

  Future<void> addPost(String title, String body) async {
    emit(Loading());
    try {
      await _apiRepository.addPost(title, body, int.parse(OWN_USER_ID));
      logInAndRetrieveData();
    } catch (APIError) {
      emit(Error());
    }
  }
}
