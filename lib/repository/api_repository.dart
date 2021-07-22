import 'dart:async';
import 'package:simple_social_app/models/comment.dart';
import 'package:simple_social_app/models/post.dart';
import 'package:simple_social_app/models/user.dart';
import 'package:simple_social_app/repository/api_responses/get_albums_for_user_response.dart';
import 'package:simple_social_app/repository/api_responses/get_comments_for_post_response.dart';
import 'package:simple_social_app/repository/api_responses/get_photos_for_album.dart';
import 'package:simple_social_app/repository/api_responses/get_posts_for_user_response.dart';
import 'api_client.dart';

class APIRepository {
  final APIClient apiClient;

  APIRepository({required this.apiClient}) : assert(apiClient != null);

  Future<User> getUserSelf() async {
    return apiClient.getUserSelf();
  }

  Future<List<Post>> getPosts() async {
    return apiClient.getPosts();
  }

  Future<List<Comment>> getCommentsForPost(String postID) async {
    return apiClient.getCommentsForPost(postID.trim());
  }

  Future<User> getUser(String userID) async {
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