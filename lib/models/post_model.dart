import 'dart:convert';

import 'package:blinqpay/app/utils/math_util.dart';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  String? thumbnail;
  String? userId;
  String? id;
  bool? noMedia;
  String? link;
  String? username;
  String? description;
  int? timestamp;
  bool? video;
  List<String> likes;
  int? likeCount;
  int? commentCount;

  Post(
      {this.thumbnail,
      this.userId,
      this.id,
      this.noMedia,
      this.link,
      this.username,
      this.description,
      this.timestamp,
      this.video,
      this.likes = const [],
      this.likeCount,
      this.commentCount});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        thumbnail: json["thumbnail"],
        userId: json["userId"],
        id: json["id"],
        noMedia: bool.tryParse(json["no_media"].toString()) ?? false,
        link: json["link"],
        username: json["username"],
        description: json["description"],
        timestamp: json["timestamp"],
        video: bool.tryParse(json["video"].toString()) ?? false,
        likes: [],
        likeCount: MathUtil.random(1000),
        commentCount: MathUtil.random(1000));
  }

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail,
        "userId": userId,
        "id": id,
        "no_media": noMedia,
        "link": link,
        "username": username,
        "description": description,
        "timestamp": timestamp,
        "video": video,
      };
}
