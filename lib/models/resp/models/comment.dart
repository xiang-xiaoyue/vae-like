// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/models/resp/models/post.dart';

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'comment.g.dart';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

@JsonSerializable()
class Comment {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "at_user_list")
  List<int?> atUserList;
  @JsonKey(name: "is_liking")
  bool isLiking;
  @JsonKey(name: "create_time")
  int createTime;
  @JsonKey(name: "delete_time")
  int deleteTime;
  @JsonKey(name: "update_time")
  int updateTime;
  @JsonKey(name: "location_name")
  String locationName;
  @JsonKey(name: "content")
  String content;
  @JsonKey(name: "pic_url")
  String picUrl;
  @JsonKey(name: "voice_url")
  String voiceUrl;
  @JsonKey(name: "post_id")
  int postId;
  @JsonKey(name: "floor_number")
  int floorNumber;
  @JsonKey(name: "parent_id")
  int parentId;
  @JsonKey(name: "parent")
  Comment? parent;
  @JsonKey(name: "post")
  Post? post;
  @JsonKey(name: "child_count")
  int childCount;
  @JsonKey(name: "top_id")
  int topId;
  @JsonKey(name: "like_count")
  int likeCount;
  @JsonKey(name: "user")
  User user;

  Comment({
    required this.id,
    required this.atUserList,
    required this.isLiking,
    required this.createTime,
    required this.deleteTime,
    required this.updateTime,
    required this.locationName,
    required this.content,
    required this.picUrl,
    required this.voiceUrl,
    required this.postId,
    required this.floorNumber,
    required this.parentId,
    required this.parent,
    required this.post,
    required this.childCount,
    required this.topId,
    required this.likeCount,
    required this.user,
  });

  Comment copyWith({
    int? id,
    List<int>? atUserList,
    bool? isLiking,
    int? createTime,
    int? deleteTime,
    int? updateTime,
    String? locationName,
    String? content,
    String? picUrl,
    String? voiceUrl,
    int? postId,
    int? floorNumber,
    int? parentId,
    dynamic parent,
    dynamic post,
    int? childCount,
    int? topId,
    User? user,
    int? likeCount,
  }) =>
      Comment(
        id: id ?? this.id,
        atUserList: atUserList ?? this.atUserList,
        isLiking: isLiking ?? this.isLiking,
        createTime: createTime ?? this.createTime,
        deleteTime: deleteTime ?? this.deleteTime,
        updateTime: updateTime ?? this.updateTime,
        locationName: locationName ?? this.locationName,
        content: content ?? this.content,
        picUrl: picUrl ?? this.picUrl,
        voiceUrl: voiceUrl ?? this.voiceUrl,
        postId: postId ?? this.postId,
        floorNumber: floorNumber ?? this.floorNumber,
        parentId: parentId ?? this.parentId,
        parent: parent ?? this.parent,
        post: post ?? this.post,
        childCount: childCount ?? this.childCount,
        topId: topId ?? this.topId,
        likeCount: likeCount ?? this.likeCount,
        user: user ?? this.user,
      );

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
