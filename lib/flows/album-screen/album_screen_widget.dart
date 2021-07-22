import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:simple_social_app/flows/album-screen/album_screen_cubit.dart';
import 'package:simple_social_app/models/album.dart';

import 'package:simple_social_app/models/photo.dart';
import 'package:simple_social_app/models/post.dart';

class AlbumScreenWidgetArguments {
  final Album album;

  AlbumScreenWidgetArguments(this.album);
}

class AlbumScreenWidget extends StatelessWidget {
  const AlbumScreenWidget() : super();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as AlbumScreenWidgetArguments;

    return BlocConsumer<AlbumScreenCubit, AlbumScreenState>(
        listener: (context, state) {
      if (state is Error) {
        Alert(
                context: context,
                title: "Error",
                desc: "Something went wrong retrieving comments")
            .show();
      }
    }, builder: (context, state) {
      if (state is AlbumScreenInitial) {
        context.read<AlbumScreenCubit>().retrieveData(args.album);
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
          appBar: AppBar(
            title: Text("Album"),
            centerTitle: true,
          ),
          body: Column(
            children: [
              _albumHeaderWidget(context, args.album),
              _photosContainer(context, state),
            ],
          ),
        );
      }
      return Container(
        color: Colors.white,
      );
    });
  }

  Widget _albumHeaderWidget(BuildContext context, Album album) {
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
            height: 16,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              album.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _photosContainer(BuildContext context, LoadedData state) {
    return Expanded(
        child: GridView.count(
      crossAxisCount: 2,
      children: List.generate(state.photos.length, (index) {
        return _photoWidget(context, state.photos[index]);
      }),
    ));
  }

  Widget _photoWidget(BuildContext context, Photo photo) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color(0xFFe0f2f1),
        ),
        child: Image.network(photo.thumbnailUrl),
      ),
    );
  }
}
