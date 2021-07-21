import 'dart:async';
import 'package:simple_social_app/repository/api_responses/get_albums_for_user_response.dart';
import 'package:simple_social_app/repository/api_responses/get_comments_for_post_response.dart';
import 'package:simple_social_app/repository/api_responses/get_photos_for_album.dart';
import 'package:simple_social_app/repository/api_responses/get_posts_for_user_response.dart';
import 'package:simple_social_app/repository/api_responses/get_posts_response.dart';
import 'package:simple_social_app/repository/api_responses/get_user_response.dart';
import 'api_client.dart';

class APIRepository {
  final APIClient apiClient;

  APIRepository({required this.apiClient}) : assert(apiClient != null);

  Future<GetUserResponse> getUserSelf() async {
    return apiClient.getUserSelf();
  }

  Future<GetPostsResponse> getPosts() async {
    return apiClient.getPosts();
  }

  Future<GetCommentsForPostResponse> getCommentsForPost(String postID) async {
    return apiClient.getCommentsForPost(postID.trim());
  }

  Future<GetUserResponse> getUser(String userID) async {
    return apiClient.getUser(userID.trim());
  }

  Future<GetPostsForUser> getPostsForUser(String userID) async {
    return apiClient.getPostsForUser(userID.trim());
  }

  Future<GetAlbumsForUserResponse> getAlbumsForUser(String userID) async {
    return apiClient.getAlbumsForUser(userID.trim());
  }

  Future<GetPhotosForAlbumResponse> getPhotosForAlbum(String albumID) async {
    return apiClient.getPhotosForAlbum(albumID.trim());
  }
}