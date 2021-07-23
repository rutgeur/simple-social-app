import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:simple_social_app/flows/post-screen/post_screen_cubit.dart';
import 'package:simple_social_app/flows/user-profile-screen/user_profile_screen_widget.dart';
import 'package:simple_social_app/models/comment.dart';
import 'package:simple_social_app/models/post.dart';

class PostScreenWidgetArguments {
  final Post post;

  PostScreenWidgetArguments(this.post);
}

class PostScreenWidget extends StatelessWidget {
  const PostScreenWidget() : super();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PostScreenWidgetArguments;

    return BlocConsumer<PostScreenCubit, PostScreenState>(
        listener: (context, state) {
      if (state is Error) {
        Alert(
                context: context,
                title: "Error",
                desc: "Something went wrong retrieving data")
            .show();
      }
    }, builder: (context, state) {
      if (state is PostScreenInitial) {
        context.read<PostScreenCubit>().retrieveData(args.post);
      }
      if (state is LoadedData) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Post Details"),
            centerTitle: true,
          ),
          body: Column(
            children: [
              _postHeaderWidget(context, args.post),
              _commentsContainer(context, state),
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

  Widget _postHeaderWidget(BuildContext context, Post post) {
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
                      arguments: UserProfileScreenWidgetArguments(null, post.userId));
                },
                child: Container(
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
        ],
      ),
    );
  }

  Widget _commentsContainer(BuildContext context, LoadedData state) {
    return Expanded(
        child: ListView.builder(
      itemCount: state.comments.length,
      itemBuilder: (context, position) {
        return _commentWidget(context, state.comments[position]);
      },
    ));
  }

  Widget _commentWidget(BuildContext context, Comment comment) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color(0xFFe0f2f1),
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
                        arguments: UserProfileScreenWidgetArguments(null, 1));
                  },
                  child: Container(
                  width: 60,
                  height: 60,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
                )),
                Container(
                  width: 8,
                ),
                Flexible(
                  child: Text(
                    comment.name,
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
                  child: Text(comment.body,
                      style: TextStyle(fontWeight: FontWeight.w400)),
                )
              ],
            ),
            Container(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
