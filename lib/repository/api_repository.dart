import 'dart:async';
import 'api_client.dart';
import 'package:simple_social_app/models/photo.dart';
import 'package:simple_social_app/models/album.dart';
import 'package:simple_social_app/models/comment.dart';
import 'package:simple_social_app/models/post.dart';
import 'package:simple_social_app/models/user.dart';

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

  Future<List<Post>> getPostsForUser(String userID) async {
    return apiClient.getPostsForUser(userID.trim());
  }

  Future<List<Album>> getAlbumsForUser(String userID) async {
    return apiClient.getAlbumsForUser(userID.trim());
  }

  Future<List<Photo>> getPhotosForAlbum(String albumID) async {
    return apiClient.getPhotosForAlbum(albumID.trim());
  }
}