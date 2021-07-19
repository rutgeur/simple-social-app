import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_social_app/helpers/constants.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitial());

  Future<void> logInAndRetrieveData() async {
    emit(Loading());
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(LOGGED_IN_KEY, true);
    emit(LoadedData());
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(LOGGED_IN_KEY, false);
    emit(LoggedOut());
  }
}
