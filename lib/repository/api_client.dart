import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
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
    final uri = Uri.parse(BASE_URL + "/users/$OWN_USER_ID");
    final response = await this.httpClient.get(uri);

    if (response.statusCode == 200) {
      return GetUserResponse.fromJson(jsonDecode(response.body.toString()));
    }

    throw _handleHTTPException(response);
  }

  Future<GetPostsResponse> getPosts() async {
    final uri = Uri.parse(BASE_URL + "/posts");
    final response = await this.httpClient.get(uri);

    if (response.statusCode == 200) {
      return GetPostsResponse.fromJson(jsonDecode(response.body.toString()));
    }

    throw _handleHTTPException(response);
  }

  Future<GetCommentsForPostResponse> getCommentsForPost(String postID) async {
    final uri = Uri.parse(BASE_URL + "/posts/$postID/comments");
    final response = await this.httpClient.get(uri);

    if (response.statusCode == 200) {
      return GetCommentsForPostResponse.fromJson(
          jsonDecode(response.body.toString()));
    }

    throw _handleHTTPException(response);
  }

  /// APIs needed for user detail page
  Future<GetUserResponse> getUser(String userID) async {
    final uri = Uri.parse(BASE_URL + "/users/$userID");
    final response = await this.httpClient.get(uri);

    if (response.statusCode == 200) {
      return GetUserResponse.fromJson(jsonDecode(response.body.toString()));
    }

    throw _handleHTTPException(response);
  }

  Future<GetPostsForUser> getPostsForUser(String userID) async {
    final uri = Uri.parse(BASE_URL + "/user/$userID/posts");
    final response = await this.httpClient.get(uri);

    if (response.statusCode == 200) {
      return GetPostsForUser.fromJson(jsonDecode(response.body.toString()));
    }

    throw _handleHTTPException(response);
  }

  Future<GetAlbumsForUserResponse> getAlbumsForUser(String userID) async {
    final uri = Uri.parse(BASE_URL + "/user/$userID/albums");
    final response = await this.httpClient.get(uri);

    if (response.statusCode == 200) {
      return GetAlbumsForUserResponse.fromJson(
          jsonDecode(response.body.toString()));
    }

    throw _handleHTTPException(response);
  }

  /// Photo album detail page
  Future<GetPhotosForAlbumResponse> getPhotosForAlbum(String albumID) async {
    final uri = Uri.parse(BASE_URL + "/albums/$albumID/photos");
    final response = await this.httpClient.get(uri);

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
