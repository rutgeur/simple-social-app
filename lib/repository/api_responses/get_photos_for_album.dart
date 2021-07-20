class GetPhotosForAlbumResponse {
  int albumId = 0;
  int id = 0;
  String title = "";
  String url = "";
  String thumbnailUrl = "";

  GetPhotosForAlbumResponse(
      {required this.albumId, required this.id, required this.title, required this.url, required this.thumbnailUrl});

  GetPhotosForAlbumResponse.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumId'] = this.albumId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}
