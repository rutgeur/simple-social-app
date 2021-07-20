import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:simple_social_app/helpers/constants.dart';
import 'package:simple_social_app/models/api_exception.dart';
import 'package:simple_social_app/repository/api_responses/get_albums_for_user_response.dart';
import 'package:simple_social_app/repository/api_responses/get_comments_for_post_response.dart';
import 'package:simple_social_app/repository/api_responses/get_photos_for_album.dart';
import 'package:simple_social_app/repository/api_responses/get_posts_for_user_response.dart';
import 'package:simple_social_app/repository/api_responses/get_posts_response.dart';
import 'package:simple_social_app/repository/api_responses/get_user_response.dart';

class APIClient {
  final http.Client httpClient;

  APIClient({
    required this.httpClient,
  });

  /// APIs needed for homepage
  Future<GetUserResponse> getUserSelf() async {
    final uri = Uri.http(BASE_URL, "/users/$OWN_USER_ID");
    Map<String, String> headers = {"Content-type": "application/json"};

    final response = await this.httpClient.post(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return GetUserResponse.fromJson(
          jsonDecode(response.body.toString()));
    }

    throw _handleHTTPException(response);
  }

  Future<GetPosts> getPosts() async {
    final uri = Uri.http(BASE_URL, "/posts");
    Map<String, String> headers = {"Content-type": "application/json"};

    final response = await this.httpClient.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return GetPosts.fromJson(
          jsonDecode(response.body.toString()));
    }

    throw _handleHTTPException(response);
  }

  Future<GetCommentsForPostResponse> getCommentsForPost(String postID) async {
    final uri = Uri.http(BASE_URL, "/posts/$postID/comments");
    Map<String, String> headers = {"Content-type": "application/json"};

    final response = await this.httpClient.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return GetCommentsForPostResponse.fromJson(
          jsonDecode(response.body.toString()));
    }

    throw _handleHTTPException(response);
  }

  /// APIs needed for user detail page
  Future<GetUserResponse> getUser(String userID) async {
    final uri = Uri.http(BASE_URL, "/users/$userID");
    Map<String, String> headers = {"Content-type": "application/json"};

    final response = await this.httpClient.post(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return GetUserResponse.fromJson(
          jsonDecode(response.body.toString()));
    }

    throw _handleHTTPException(response);
  }

  Future<GetPostsForUser> getPostsForUser(String userID) async {
    final uri = Uri.http(BASE_URL, "/user/$userID/posts");
    Map<String, String> headers = {"Content-type": "application/json"};

    final response = await this.httpClient.post(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return GetPostsForUser.fromJson(
          jsonDecode(response.body.toString()));
    }

    throw _handleHTTPException(response);
  }

  Future<GetAlbumsForUserResponse> getAlbumsForUser(String userID) async {
    final uri = Uri.http(BASE_URL, "/user/$userID/albums");
    Map<String, String> headers = {"Content-type": "application/json"};

    final response = await this.httpClient.post(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return GetAlbumsForUserResponse.fromJson(
          jsonDecode(response.body.toString()));
    }

    throw _handleHTTPException(response);
  }

  /// Photo album detail page
  Future<GetPhotosForAlbumResponse> getPhotosForAlbum(String albumID) async {
    final uri = Uri.http(BASE_URL, "/albums/$albumID/photos");
    Map<String, String> headers = {"Content-type": "application/json"};

    final response = await this.httpClient.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return GetPhotosForAlbumResponse.fromJson(
          jsonDecode(response.body.toString()));
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