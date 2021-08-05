import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_social_app/flows/home-screen/home_screen_cubit.dart';
import 'package:simple_social_app/models/post.dart';

import '../mock_api_repository.dart';

void main() {
  group('HomeScreenCubit test', () {
    late HomeScreenCubit homeScreenCubit;
    late MockAPIRepository mockAPIRepository;

    setUp(() {
      mockAPIRepository = MockAPIRepository();
      homeScreenCubit = HomeScreenCubit(mockAPIRepository);
      SharedPreferences.setMockInitialValues({});
    });

    blocTest<HomeScreenCubit, HomeScreenState>(
      'emits [Loading, LoadedData] states for'
          'logInAndRetrieveData',
      build: () => homeScreenCubit,
      act: (cubit) => cubit.logInAndRetrieveData(),
      expect: () => [
        isA<Loading>(),
        isA<LoadedData>()
      ]
    );

    blocTest<HomeScreenCubit, HomeScreenState>(
        'emits [LoggedOut] states for'
            'logOut',
        build: () => homeScreenCubit,
        act: (cubit) => cubit.logOut(),
        expect: () => [
          isA<LoggedOut>()
        ]
    );

    blocTest<HomeScreenCubit, HomeScreenState>(
        'emits [Loading, Loading, LoadedData] states for'
            'deletePost',
        build: () => homeScreenCubit,
        act: (cubit) => cubit.deletePost(Post(userId: 1, id: 1, title: "", body: "")),
        expect: () => [
          isA<Loading>(),
          isA<Loading>(),
          isA<LoadedData>()
        ]
    );

    blocTest<HomeScreenCubit, HomeScreenState>(
        'emits [Loading, Loading, LoadedData] states for'
            'addPost',
        build: () => homeScreenCubit,
        act: (cubit) => cubit.addPost("Title", "Body"),
        expect: () => [
          isA<Loading>(),
          isA<Loading>(),
          isA<LoadedData>()
        ]
    );

    tearDown(() {
      homeScreenCubit.close();
    });
  });
}