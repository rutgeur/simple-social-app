import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:simple_social_app/flows/album-screen/album_screen_widget.dart';
import 'package:simple_social_app/flows/post-screen/post_screen_widget.dart';
import 'package:simple_social_app/flows/user-profile-screen/user_profile_screen_cubit.dart';
import 'package:simple_social_app/helpers/constants.dart';
import 'package:simple_social_app/models/album.dart';
import 'package:simple_social_app/models/post.dart';
import 'package:simple_social_app/models/user.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class UserProfileScreenWidgetArguments {
  final User? user;
  final int? userID;

  UserProfileScreenWidgetArguments(this.user, this.userID);
}

class UserProfileScreenWidget extends StatelessWidget {
  const UserProfileScreenWidget() : super();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as UserProfileScreenWidgetArguments;

    return BlocConsumer<UserProfileScreenCubit, UserProfileScreenState>(
        listener: (context, state) {
      if (state is Error) {
        Alert(
                context: context,
                title: "Error",
                desc: "Something went wrong retrieving data")
            .show();
      }
    }, builder: (context, state) {
      if (state is UserProfileScreenInitial) {
        context
            .read<UserProfileScreenCubit>()
            .retrieveData(args.user, args.userID);
      }
      if (state is LoadedData) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Profile"),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/back-to-home-screen');
              },
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
          body: Column(
            children: [
              _userProfileHeaderWidget(context, state.user),
              _tabBarContainer(context, state),
            ],
          ),
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

  Widget _userProfileHeaderWidget(BuildContext context, User user) {
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
                    Alert(
                            context: context,
                            title: "Already There",
                            desc:
                                "You're already viewing the users profile that you have tapped into")
                        .show();
                  },
                  child: Container(
                    child: Icon(Icons.person),
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFe0f2f1)),
                  )),
              Container(
                width: 8,
              ),
              Flexible(
                child: Text(
                  user.username,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
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
                child: Text("Name: " + user.name,
                    style: TextStyle(fontWeight: FontWeight.w400)),
              )
            ],
          ),
          Row(
            children: [
              Container(
                width: 16,
              ),
              Flexible(
                child: Text("Website: " + user.website,
                    style: TextStyle(fontWeight: FontWeight.w400)),
              )
            ],
          ),
          Row(
            children: [
              Container(
                width: 16,
              ),
              Flexible(
                child: Text("Phone Number: " + user.phone,
                    style: TextStyle(fontWeight: FontWeight.w400)),
              )
            ],
          ),
          Row(
            children: [
              Container(
                width: 16,
              ),
              Flexible(
                child: Text("Email: " + user.email,
                    style: TextStyle(fontWeight: FontWeight.w400)),
              )
            ],
          ),
          Container(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _tabBarContainer(BuildContext context, LoadedData state) {
    return Expanded(
        child: ContainedTabBarView(
      tabs: [
        Text("Posts", style: TextStyle(color: Colors.black)),
        Text("Albums", style: TextStyle(color: Colors.black)),
      ],
      views: [
        _postsContainer(context, state),
        _albumsContainer(context, state)
      ],
    ));
  }

  Widget _postsContainer(BuildContext context, LoadedData state) {
    return Container(
        child: ListView.builder(
      itemCount: state.posts.length,
      itemBuilder: (context, position) {
        return _postWidget(context, state, state.posts[position]);
      },
    ));
  }

  Widget _postWidget(BuildContext context, LoadedData state, Post post) {
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
                    Alert(
                            context: context,
                            title: "Already There",
                            desc:
                                "You're already viewing the users profile that you have tapped into")
                        .show();
                  },
                  child: Container(
                    child: Icon(Icons.person),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFe0f2f1)),
                  )),
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
                                  context
                                      .read<UserProfileScreenCubit>()
                                      .deletePost(state.user, post)
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

  Widget _albumsContainer(BuildContext context, LoadedData state) {
    return Container(
        child: ListView.builder(
      itemCount: state.albums.length,
      itemBuilder: (context, position) {
        return _albumWidget(context, state.albums[position]);
      },
    ));
  }

  Widget _albumWidget(BuildContext context, Album album) {
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
              Flexible(
                child: Text(
                  "Album Name:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 16,
              ),
              Flexible(
                child: Text(
                  album.title,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
          Container(
            height: 16,
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/album',
                    arguments: AlbumScreenWidgetArguments(album));
              },
              child: Text("View Album"))
        ],
      ),
    );
  }
}
