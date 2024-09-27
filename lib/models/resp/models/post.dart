//     final post = postFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:trump/models/resp/models/user.dart';
import 'package:trump/models/resp/models/vote_result_item.dart';
import 'package:trump/models/resp/models/subject.dart';

part 'post.g.dart';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

@JsonSerializable()
class Post {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "currency_type")
  String currencyType;
  @JsonKey(name: "currency_count")
  int currencyCount;
  @JsonKey(name: "vote_result")
  List<VoteResultItem>? voteResult;
  @JsonKey(name: "create_time")
  int createTime;
  @JsonKey(name: "color")
  String color;
  @JsonKey(name: "delete_time")
  int deleteTime;
  @JsonKey(name: "update_time")
  int updateTime;
  @JsonKey(name: "location_name")
  String locationName;
  @JsonKey(name: "user_id")
  int userId;
  @JsonKey(name: "like_count")
  int likeCount;
  @JsonKey(name: "comment_count")
  int commentCount;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "content")
  String content;
  @JsonKey(name: "subject")
  Subject subject;
  @JsonKey(name: "start_time")
  int startTime;
  @JsonKey(name: "end_time")
  int endTime;
  @JsonKey(name: "is_glory")
  bool isGlory;
  @JsonKey(name: "view_count")
  int viewCount;
  @JsonKey(name: "image_list")
  List<String> imageList;
  @JsonKey(name: "poster_url")
  String posterUrl;
  @JsonKey(name: "video_url")
  String videoUrl;
  @JsonKey(name: "voice_url")
  String voiceUrl;
  @JsonKey(name: "music_url")
  String musicUrl;
  @JsonKey(name: "at_user_list")
  List<int> atUserList;
  @JsonKey(name: "type")
  String type;
  @JsonKey(name: "sub_type")
  String subType;
  @JsonKey(name: "is_liking")
  bool isLiking;
  @JsonKey(name: "is_collecting")
  bool isCollecting;
  @JsonKey(name: "user")
  User user;

  Post({
    required this.id,
    required this.status,
    required this.currencyType,
    required this.currencyCount,
    this.voteResult,
    required this.color,
    required this.createTime,
    required this.deleteTime,
    required this.updateTime,
    required this.locationName,
    required this.userId,
    required this.likeCount,
    required this.commentCount,
    required this.title,
    required this.content,
    required this.subject,
    required this.startTime,
    required this.endTime,
    required this.isGlory,
    required this.viewCount,
    required this.imageList,
    required this.posterUrl,
    required this.videoUrl,
    required this.voiceUrl,
    required this.musicUrl,
    required this.atUserList,
    required this.type,
    required this.subType,
    required this.isLiking,
    required this.isCollecting,
    required this.user,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
