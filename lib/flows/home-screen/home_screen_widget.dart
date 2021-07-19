import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:simple_social_app/flows/home-screen/home_screen_cubit.dart';
import 'package:simple_social_app/flows/landing-page/landing_page_widget.dart';

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget() : super();

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    return BlocConsumer<HomeScreenCubit, HomeScreenState>(
        listener: (context, state) {
      if (state is Error) {
        Alert(
                context: context,
                title: "Error",
                desc: "Something went wrong check logged in state")
            .show();
      }
      if (state is LoggedOut) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LandingPageWidget()),
            ModalRoute.withName('/landing-page'));
      }
    }, builder: (context, state) {
      if (state is HomeScreenInitial) {
        context.read<HomeScreenCubit>().logInAndRetrieveData();
      }
      if (state is Loading) {
        // TODO: Show spinner
        return SpinKitChasingDots(
          color: Colors.blue,
          size: 50.0,
        );
      }
      return Scaffold(
          appBar: AppBar(),
          drawer: _drawerContainer(context),
          body: Container(
            // color: Colors.pink,
          ));
    });
  }

  Widget _drawerContainer(BuildContext context) => Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                  child: Container(
                      width: double.infinity,
                      child: Text(
                        '',
                        style: TextStyle(fontSize: 16.0),
                      ))),
            ),
            ListTile(
              title: Text('Log Out'),
              onTap: () {
                context.read<HomeScreenCubit>().logOut();
              },
            ),
          ],
        ),
      );
}
