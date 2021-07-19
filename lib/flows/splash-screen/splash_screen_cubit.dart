import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_social_app/helpers/constants.dart';

part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(SplashScreenInitial());

  Future<void> checkIfLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    bool? loggedIn = prefs.getBool(LOGGED_IN_KEY);
    if (loggedIn != null) {
      loggedIn ? emit(LoggedIn()) : emit(NotLoggedIn());
      return;
    }
    emit(NotLoggedIn());
  }
}
