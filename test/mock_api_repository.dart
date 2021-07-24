import 'package:simple_social_app/models/address.dart';
import 'package:simple_social_app/models/album.dart';
import 'package:simple_social_app/models/comment.dart';
import 'package:simple_social_app/models/company.dart';
import 'package:simple_social_app/models/geo.dart';
import 'package:simple_social_app/models/photo.dart';
import 'package:simple_social_app/models/post.dart';
import 'package:simple_social_app/models/user.dart';
import 'package:simple_social_app/repository/api_client.dart';
import 'package:simple_social_app/repository/api_repository.dart';

class MockAPIRepository implements APIRepository {
  @override
  APIClient get apiClient => throw UnimplementedError();

  @override
  Future<User> getUserSelf() async {
    return User(
        id: 1,
        name: "",
        username: "",
        email: "",
        address: Address(
            street: "",
            suite: "",
            city: "",
            zipcode: "",
            geo: Geo(lat: "", lng: "")),
        phone: "",
        website: "",
        company: Company(name: "", catchPhrase: "", bs: ""));
  }

  @override
  Future<List<Post>> getPosts() async {
    List<Post> response = [];
    return response;
  }

  @override
  Future<List<Comment>> getCommentsForPost(String postID) async {
    return apiClient.getCommentsForPost(postID.trim());
  }

  @override
  Future<User> getUser(String userID) async {
    return apiClient.getUser(userID.trim());
  }

  @override
  Future<List<Post>> getPostsForUser(String userID) async {
    return apiClient.getPostsForUser(userID.trim());
  }

  @override
  Future<List<Album>> getAlbumsForUser(String userID) async {
    return apiClient.getAlbumsForUser(userID.trim());
  }

  @override
  Future<List<Photo>> getPhotosForAlbum(String albumID) async {
    return apiClient.getPhotosForAlbum(albumID.trim());
  }

  @override
  Future<void> deletePost(String postID) async {
    return;
  }

  @override
  Future<void> updatePost(
      int postID, int userID, String title, String body) async {
    return apiClient.updatePost(postID, userID, title.trim(), body.trim());
  }

  @override
  Future<void> addPost(String title, String body, int userID) async {
    return;
  }
}
