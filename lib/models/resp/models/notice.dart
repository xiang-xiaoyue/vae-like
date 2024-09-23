// To parse this JSON data, do
//
//     final notice = noticeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'notice.g.dart';

Notice noticeFromJson(String str) => Notice.fromJson(json.decode(str));

String noticeToJson(Notice data) => json.encode(data.toJson());

@JsonSerializable()
class Notice {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "create_time")
  int createTime;
  @JsonKey(name: "delete_time")
  int deleteTime;
  @JsonKey(name: "update_time")
  int updateTime;
  @JsonKey(name: "location_name")
  String locationName;
  @JsonKey(name: "user_id")
  int userId;
  @JsonKey(name: "user_avatar")
  String userAvatar;
  @JsonKey(name: "username")
  String username;
  @JsonKey(name: "content")
  String content;
  @JsonKey(name: "subject_floor")
  int subjectFloor;
  @JsonKey(name: "subject_like_count")
  int subjectLikeCount;
  @JsonKey(name: "object_image_url")
  String objectImageUrl;
  @JsonKey(name: "ojbect_display_name")
  String ojbectDisplayName;
  @JsonKey(name: "object_create_time")
  int objectCreateTime;
  @JsonKey(name: "object_content")
  String objectContent;
  @JsonKey(name: "object_reply_count")
  int objectReplyCount;
  @JsonKey(name: "ojbect_floor")
  int ojbectFloor;
  @JsonKey(name: "object_id")
  int objectId;
  @JsonKey(name: "object_type")
  String objectType;
  @JsonKey(name: "type")
  String type;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "post_id")
  int postId;
  @JsonKey(name: "object_author_id")
  int objectAuthorId;

  Notice({
    required this.id,
    required this.createTime,
    required this.deleteTime,
    required this.updateTime,
    required this.locationName,
    required this.userId,
    required this.userAvatar,
    required this.username,
    required this.content,
    required this.subjectFloor,
    required this.subjectLikeCount,
    required this.objectImageUrl,
    required this.ojbectDisplayName,
    required this.objectCreateTime,
    required this.objectContent,
    required this.objectReplyCount,
    required this.ojbectFloor,
    required this.objectId,
    required this.objectType,
    required this.type,
    required this.status,
    required this.postId,
    required this.objectAuthorId,
  });

  factory Notice.fromJson(Map<String, dynamic> json) => _$NoticeFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeToJson(this);
}
