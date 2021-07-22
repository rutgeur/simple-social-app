import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:simple_social_app/flows/home-screen/home_screen_cubit.dart';
import 'package:simple_social_app/flows/landing-page/landing_page_widget.dart';
import 'package:simple_social_app/flows/post-screen/post_screen_widget.dart';
import 'package:simple_social_app/models/post.dart';

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget() : super();

  @override
  Widget build(BuildContext context) {
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
        return Container(
          color: Colors.white,
          child: Center(
            child: SpinKitChasingDots(
              color: Colors.blue,
              size: 50.0,
            ),
          ),
        );
      }
      if (state is LoadedData) {
        return Scaffold(
          appBar: AppBar(),
          drawer: _drawerContainer(context),
          body: Column(children: [_postsContainer(context, state)]),
        );
      }
      return Container(
        color: Colors.white,
        child: Center(
          child: SpinKitChasingDots(
            color: Colors.blue,
            size: 50.0,
          ),
        ),
      );
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

  Widget _postsContainer(BuildContext context, LoadedData state) {
    return Expanded(
        child: ListView.builder(
      itemCount: state.posts.length,
      itemBuilder: (context, position) {
        return _postWidget(context, state.posts[position]);
      },
    ));
  }

  Widget _postWidget(BuildContext context, Post post) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.lightBlue.shade900),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            height: 8,
          ),
          Row(
            children: [
              Container(
                width: 16,
              ),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFFe0f2f1)),
              ),
              Container(
                width: 8,
              ),
              Flexible(
                child: Text(
                  post.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Container(
            height: 8,
          ),
          Row(
            children: [
              Container(
                width: 16,
              ),
              Flexible(
                child: Text(post.body,
                    style: TextStyle(fontWeight: FontWeight.w400)),
              )
            ],
          ),
          Container(
            height: 16,
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/post-screen',
                    arguments: PostScreenWidgetArguments(post));
              },
              child: Text("View Comments"))
        ],
      ),
    );
  }
}
