// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  String? userId;
  String? username;
  String? name;
  String? photo;
  String? bio;

  User({
    this.userId,
    this.username,
    this.name,
    this.photo,
    this.bio,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        username: json["username"],
        name: json["name"],
        photo: json["photo"],
        bio: json["bio"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": username,
        "name": name,
        "photo": photo,
        "bio": bio,
      };
}
