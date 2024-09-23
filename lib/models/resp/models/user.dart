// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import './currency.dart';
import 'dart:convert';

part 'user.g.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "roles")
  List<String?> roles;
  @JsonKey(name: "is_blocking")
  bool isBlocking;
  @JsonKey(name: "like_count")
  int likeCount;
  @JsonKey(name: "series_checkin_days")
  int seriesCheckinDays;
  @JsonKey(name: "total_checkin_days")
  int totalCheckinDays;
  @JsonKey(name: "is_following")
  bool isFollowing;
  @JsonKey(name: "is_liking")
  bool isLiking;
  @JsonKey(name: "currency")
  Map<String, int> currency;
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
  @JsonKey(name: "password")
  String password;
  @JsonKey(name: "phone")
  String phone;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "age")
  int age;
  @JsonKey(name: "gender")
  String gender;
  @JsonKey(name: "avatar_url")
  String avatarUrl;
  @JsonKey(name: "birthday")
  int birthday;
  @JsonKey(name: "sign")
  String sign;
  @JsonKey(name: "level")
  int level;
  @JsonKey(name: "progress")
  int progress;
  @JsonKey(name: "fan_count")
  int fanCount;
  @JsonKey(name: "following_user_count")
  int followingUserCount;
  @JsonKey(name: "friend_count")
  int friendCount;

  User({
    required this.id,
    required this.roles,
    required this.likeCount,
    required this.seriesCheckinDays,
    required this.totalCheckinDays,
    required this.isFollowing,
    required this.isLiking,
    required this.isBlocking,
    required this.currency,
    required this.createTime,
    required this.deleteTime,
    required this.updateTime,
    required this.locationName,
    required this.name,
    required this.password,
    required this.phone,
    required this.email,
    required this.age,
    required this.gender,
    required this.avatarUrl,
    required this.birthday,
    required this.sign,
    required this.level,
    required this.progress,
    required this.fanCount,
    required this.followingUserCount,
    required this.friendCount,
  });

  User copyWith({
    int? id,
    List<String?>? roles,
    int? likeCount,
    int? seriesCheckinDays,
    int? totalCheckinDays,
    bool? isFollowing,
    bool? isLiking,
    bool? isBlocking,
    Map<String, int>? currency,
    int? createTime,
    int? deleteTime,
    int? updateTime,
    String? locationName,
    String? name,
    String? password,
    String? phone,
    String? email,
    int? age,
    String? gender,
    String? avatarUrl,
    int? birthday,
    String? sign,
    int? level,
    int? progress,
    int? fanCount,
    int? followingUserCount,
    int? friendCount,
  }) =>
      User(
        id: id ?? this.id,
        roles: roles ?? this.roles,
        likeCount: likeCount ?? this.likeCount,
        seriesCheckinDays: seriesCheckinDays ?? this.seriesCheckinDays,
        totalCheckinDays: totalCheckinDays ?? this.totalCheckinDays,
        isFollowing: isFollowing ?? this.isFollowing,
        isLiking: isLiking ?? this.isLiking,
        isBlocking: isBlocking ?? this.isBlocking,
        currency: currency ?? this.currency,
        createTime: createTime ?? this.createTime,
        deleteTime: deleteTime ?? this.deleteTime,
        updateTime: updateTime ?? this.updateTime,
        locationName: locationName ?? this.locationName,
        name: name ?? this.name,
        password: password ?? this.password,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        age: age ?? this.age,
        gender: gender ?? this.gender,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        birthday: birthday ?? this.birthday,
        sign: sign ?? this.sign,
        level: level ?? this.level,
        progress: progress ?? this.progress,
        fanCount: fanCount ?? this.fanCount,
        followingUserCount: followingUserCount ?? this.followingUserCount,
        friendCount: friendCount ?? this.friendCount,
      );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
