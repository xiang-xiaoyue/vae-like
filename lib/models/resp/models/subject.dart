// To parse this JSON data, do
//
//     final subject = subjectFromJson(jsonString);

import './user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'subject.g.dart';

Subject subjectFromJson(String str) => Subject.fromJson(json.decode(str));

String subjectToJson(Subject data) => json.encode(data.toJson());

@JsonSerializable()
class Subject {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "user")
  User user;
  @JsonKey(name: "following_user_count")
  int followingUserCount;
  @JsonKey(name: "is_following")
  bool isFollowing;
  @JsonKey(name: "create_time")
  int createTime;
  @JsonKey(name: "delete_time")
  int deleteTime;
  @JsonKey(name: "update_time")
  int updateTime;
  @JsonKey(name: "location_name")
  String locationName;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "user_id")
  int userId;
  @JsonKey(name: "keywords")
  String keywords;
  @JsonKey(name: "summary")
  String summary;
  @JsonKey(name: "reason")
  String reason;
  @JsonKey(name: "cover_url_list")
  String coverUrlList;

  Subject({
    required this.id,
    required this.user,
    required this.followingUserCount,
    required this.isFollowing,
    required this.createTime,
    required this.deleteTime,
    required this.updateTime,
    required this.locationName,
    required this.name,
    required this.userId,
    required this.keywords,
    required this.summary,
    required this.reason,
    required this.coverUrlList,
  });

  Subject copyWith({
    int? id,
    User? user,
    int? followingUserCount,
    bool? isFollowing,
    int? createTime,
    int? deleteTime,
    int? updateTime,
    String? locationName,
    String? name,
    int? userId,
    String? keywords,
    String? summary,
    String? reason,
    String? coverUrlList,
  }) =>
      Subject(
        id: id ?? this.id,
        user: user ?? this.user,
        followingUserCount: followingUserCount ?? this.followingUserCount,
        isFollowing: isFollowing ?? this.isFollowing,
        createTime: createTime ?? this.createTime,
        deleteTime: deleteTime ?? this.deleteTime,
        updateTime: updateTime ?? this.updateTime,
        locationName: locationName ?? this.locationName,
        name: name ?? this.name,
        userId: userId ?? this.userId,
        keywords: keywords ?? this.keywords,
        summary: summary ?? this.summary,
        reason: reason ?? this.reason,
        coverUrlList: coverUrlList ?? this.coverUrlList,
      );

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}
