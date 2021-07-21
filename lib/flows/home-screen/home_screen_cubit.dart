import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_social_app/helpers/constants.dart';
import 'package:simple_social_app/models/user_model.dart';
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
      final getUserSelfResponse = await _apiRepository.getUserSelf();
      // final getPostsResponse = await _apiRepository.getPosts();
      // emit(LoadedData(getUserSelfResponse.toUser()));
      emit(LoadedData(User()));
    } catch (APIError) {
      emit(Error());
    }
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(LOGGED_IN_KEY, false);
    emit(LoggedOut());
  }
}
