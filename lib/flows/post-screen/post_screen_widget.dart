import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:simple_social_app/flows/post-screen/post_screen_cubit.dart';
import 'package:simple_social_app/flows/user-profile-screen/user_profile_screen_widget.dart';
import 'package:simple_social_app/helpers/constants.dart';
import 'package:simple_social_app/models/comment.dart';
import 'package:simple_social_app/models/post.dart';

class PostScreenWidgetArguments {
  final Post post;

  PostScreenWidgetArguments(this.post);
}

class PostScreenWidget extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PostScreenWidgetArguments;

    titleController.text = args.post.title;
    bodyController.text = args.post.body;

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
            actions: <Widget>[
              args.post.userId.toString() == OWN_USER_ID
                  ? IconButton(
                      icon: Icon(
                        Icons.edit,
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
                                      "Edit Post",
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
                                                  title: "Editing Post",
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
                                                                PostScreenCubit>()
                                                            .updatePost(
                                                                args.post,
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
                                                      "Your post will be edited. After your post is edited the screen will be refreshed. Since this is a mock back-end the post will not really be updated though.")
                                              .show();
                                        },
                                        child: Text("Save Edits")),
                                    Container(
                                      height: 32,
                                    ),
                                  ]),
                            );
                          },
                        )
                      },
                    )
                  : Container()
            ],
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
                      arguments:
                          UserProfileScreenWidgetArguments(null, post.userId));
                },
                child: Container(
                  child: Icon(Icons.person),
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
                Flexible(
                  child: Text(
                    comment.email,
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
