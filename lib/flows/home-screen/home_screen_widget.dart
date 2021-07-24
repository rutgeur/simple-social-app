import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:simple_social_app/flows/home-screen/home_screen_cubit.dart';
import 'package:simple_social_app/flows/landing-page/landing_page_widget.dart';
import 'package:simple_social_app/flows/post-screen/post_screen_widget.dart';
import 'package:simple_social_app/flows/user-profile-screen/user_profile_screen_widget.dart';
import 'package:simple_social_app/helpers/constants.dart';
import 'package:simple_social_app/models/post.dart';

class HomeScreenWidget extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenState>(
      key: Key("HomeScreenBlocKey"),
        listener: (context, state) {
      if (state is Error) {
        Alert(
                context: context,
                title: "Error",
                desc: "Something went wrong retrieving data")
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
      if (state is LoadedData) {
        return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              appBar: AppBar(
                title: Text("News Feed"),
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () => {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (_) {
                          return Container(
                            padding: EdgeInsets.only(
                              bottom:
                              MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    height: 32,
                                  ),
                                  Text(
                                    "Add Post",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(32, 0, 32, 0),
                                      child: TextField(
                                          minLines: 1,
                                          maxLines: 3,
                                          controller: titleController,
                                          decoration: InputDecoration(
                                              labelText: "Title"))),
                                  Container(
                                    height: 16,
                                  ),
                                  Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(32, 0, 32, 0),
                                      child: TextField(
                                          minLines: 2,
                                          maxLines: 5,
                                          controller: bodyController,
                                          decoration: InputDecoration(
                                              labelText: "Body"))),
                                  Container(
                                    height: 16,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Alert(
                                            context: context,
                                            title: "Adding Post",
                                            buttons: [
                                              DialogButton(
                                                color: Colors.blue,
                                                child: Text(
                                                  "Confirm",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onPressed: () => {
                                                  Navigator.pop(context),
                                                  Navigator.pop(context),
                                                  context
                                                      .read<
                                                      HomeScreenCubit>()
                                                      .addPost(
                                                      titleController
                                                          .text,
                                                      bodyController
                                                          .text),
                                                  titleController.text = "",
                                                  bodyController.text = ""
                                                },
                                                width: 160,
                                              )
                                            ],
                                            desc:
                                            "Your post will be added. After your post is added the screen will be refreshed. Since this is a mock back-end the post will not really be added though.")
                                            .show();
                                      },
                                      child: Text("Upload")),
                                  Container(
                                    height: 32,
                                  ),
                                ]),
                          );
                        },
                      )
                    },
                  )
                ],
              ),
              drawer: _drawerContainer(context, state),
              body: Column(children: [_postsContainer(context, state)]),
            ));
      }
      return Container(
        key: Key("HomeScreenLoadingContainerKey"),
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

  Widget _drawerContainer(BuildContext context, LoadedData state) => Drawer(
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/user-profile',
                    arguments:
                        UserProfileScreenWidgetArguments(state.user, null));
              },
              child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(children: [
                    Container(
                      child: Icon(Icons.person),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFe0f2f1)),
                    ),
                    Container(
                      width: 8,
                    ),
                    Container(
                        // width: double.infinity,
                        child: Text(
                      state.user.username,
                      style: TextStyle(fontSize: 16.0),
                    )),
                  ])),
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
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/user-profile',
                      arguments:
                          UserProfileScreenWidgetArguments(null, post.userId));
                },
                child: Container(
                  child: Icon(
                    Icons.person
                  ),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFFe0f2f1)),
                ),
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
              child: Text("View Comments")),
          post.userId.toString() == OWN_USER_ID
              ? TextButton(
                  onPressed: () {
                    Alert(
                        context: context,
                        title: "Deleting Post",
                        buttons: [
                          DialogButton(
                            color: Colors.blue,
                            child: Text(
                              "Confirm",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () => {
                              Navigator.pop(context),
                              context.read<HomeScreenCubit>().deletePost(post)
                            },
                            width: 160,
                          )
                        ],
                        desc:
                        "Your post will be deleted. After your post is deleted the screen will be refreshed. Since this is a mock back-end the post will not really disappear though.")
                        .show();
                  },
                  child:
                      Text("Delete Post", style: TextStyle(color: Colors.red)))
              : Container(),
        ],
      ),
    );
  }
}
