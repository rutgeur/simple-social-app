import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:simple_social_app/helpers/constants.dart';
import 'package:simple_social_app/models/album.dart';
import 'package:simple_social_app/models/api_exception.dart';
import 'package:simple_social_app/models/comment.dart';
import 'package:simple_social_app/models/photo.dart';
import 'package:simple_social_app/models/post.dart';
import 'package:simple_social_app/models/user.dart';

class APIClient {
  final http.Client httpClient;

  APIClient({
    required this.httpClient,
  });

  /// APIs needed for homepage
  Future<User> getUserSelf() async {
    final uri = Uri.parse(BASE_URL + "/users/$OWN_USER_ID");
    final response = await this.httpClient.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return User.fromJson(jsonResponse);
    }

    throw _handleHTTPException(response);
  }

  Future<List<Post>> getPosts() async {
    final uri = Uri.parse(BASE_URL + "/posts");
    final response = await this.httpClient.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<Post> posts = [];
      for(var i = 0; i < jsonResponse.length; i++){
        posts.add(Post.fromJson(jsonResponse[i]));
      }
      return posts;
    }

    throw _handleHTTPException(response);
  }

  Future<List<Comment>> getCommentsForPost(String postID) async {
    final uri = Uri.parse(BASE_URL + "/posts/$postID/comments");
    final response = await this.httpClient.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<Comment> comments = [];
      for(var i = 0; i < jsonResponse.length; i++){
        comments.add(Comment.fromJson(jsonResponse[i]));
      }
      return comments;
    }

    throw _handleHTTPException(response);
  }

  /// APIs needed for user detail page
  Future<User> getUser(String userID) async {
    final uri = Uri.parse(BASE_URL + "/users/$userID");
    final response = await this.httpClient.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return User.fromJson(jsonResponse);
    }

    throw _handleHTTPException(response);
  }

  Future<List<Post>> getPostsForUser(String userID) async {
    final uri = Uri.parse(BASE_URL + "/user/$userID/posts");
    final response = await this.httpClient.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<Post> posts = [];
      for(var i = 0; i < jsonResponse.length; i++){
        posts.add(Post.fromJson(jsonResponse[i]));
      }
      return posts;
    }

    throw _handleHTTPException(response);
  }

  Future<List<Album>> getAlbumsForUser(String userID) async {
    final uri = Uri.parse(BASE_URL + "/user/$userID/albums");
    final response = await this.httpClient.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<Album> albums = [];
      for(var i = 0; i < jsonResponse.length; i++){
        albums.add(Album.fromJson(jsonResponse[i]));
      }
      return albums;
    }

    throw _handleHTTPException(response);
  }

  /// Photo album detail page
  Future<List<Photo>> getPhotosForAlbum(String albumID) async {
    final uri = Uri.parse(BASE_URL + "/albums/$albumID/photos");
    final response = await this.httpClient.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<Photo> photos = [];
      for(var i = 0; i < jsonResponse.length; i++){
        photos.add(Photo.fromJson(jsonResponse[i]));
      }
      return photos;
    }

    throw _handleHTTPException(response);
  }

  Future<void> deletePost(String postID) async {
    final uri = Uri.parse(BASE_URL + "/posts/$postID");
    final response = await this.httpClient.delete(uri);

    if (response.statusCode == 200) {
      return;
    }

    throw _handleHTTPException(response);
  }

  Future<APIException> _handleHTTPException(http.Response response) {
    APIException apiException;
    try {
      apiException =
          APIException.fromJson(jsonDecode(response.body.toString()));
    } on FormatException {
      apiException = APIException(id: 0, message: 'Internal Server Error');
    }
    throw apiException;
  }
}
