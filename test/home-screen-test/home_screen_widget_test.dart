import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:simple_social_app/flows/home-screen/home_screen_cubit.dart';
import 'package:simple_social_app/flows/home-screen/home_screen_widget.dart';
import 'package:simple_social_app/repository/api_client.dart';
import 'package:simple_social_app/repository/api_repository.dart';

class MockHomeScreenCubit extends MockCubit<HomeScreenState> implements HomeScreenCubit {}

void main() {
  testWidgets('HomeScreenWidget test', (WidgetTester tester) async {
    final widget = Directionality(
      child: MediaQuery(
        data: MediaQueryData(),
        child: BlocProvider(
            create: (context) => HomeScreenCubit(APIRepository(
                apiClient: APIClient(httpClient: http.Client()))),
            child: HomeScreenWidget()),
      ),
      textDirection: TextDirection.ltr,
    );

    await tester.pumpWidget(widget);
    expect(find.byKey(Key("HomeScreenBlocKey")), findsOneWidget);
    expect(find.byKey(Key("HomeScreenLoadingContainerKey")), findsOneWidget);
  });
}