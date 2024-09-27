// To parse this JSON data, do
//
//     final like = likeFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'like.g.dart';

Like likeFromJson(String str) => Like.fromJson(json.decode(str));

String likeToJson(Like data) => json.encode(data.toJson());

@JsonSerializable()
class Like {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "liked_id")
  int likedId;
  @JsonKey(name: "create_time")
  int createTime;
  @JsonKey(name: "liked_type")
  String likedType;
  @JsonKey(name: "user")
  int user;
  @JsonKey(name: "user_avatar")
  String userAvatar;
  @JsonKey(name: "username")
  String username;
  @JsonKey(name: "post_id")
  int postId;
  @JsonKey(name: "content")
  String content;
  @JsonKey(name: "author_id")
  int authorId;
  @JsonKey(name: "author_name")
  String authorName;
  @JsonKey(name: "image_url")
  String imageUrl;
  @JsonKey(name: "publish_time")
  int publishTime;
  @JsonKey(name: "reply_count")
  int replyCount;
  @JsonKey(name: "floor")
  int floor;

  Like({
    required this.id,
    required this.likedId,
    required this.createTime,
    required this.likedType,
    required this.user,
    required this.userAvatar,
    required this.username,
    required this.postId,
    required this.content,
    required this.authorId,
    required this.authorName,
    required this.imageUrl,
    required this.publishTime,
    required this.replyCount,
    required this.floor,
  });

  factory Like.fromJson(Map<String, dynamic> json) => _$LikeFromJson(json);

  Map<String, dynamic> toJson() => _$LikeToJson(this);
}
