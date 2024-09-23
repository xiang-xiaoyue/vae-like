// To parse this JSON data, do
//
//     final userPreference = userPreferenceFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'user_preference.g.dart';

UserPreference userPreferenceFromJson(String str) =>
    UserPreference.fromJson(json.decode(str));

String userPreferenceToJson(UserPreference data) => json.encode(data.toJson());

// 查询与更新都用此class
@JsonSerializable()
class UserPreference {
  @JsonKey(name: "remind_comment_notice")
  bool remindCommentNotice;
  @JsonKey(name: "remind_official_notice")
  bool remindOfficialNotice;
  @JsonKey(name: "remind_at_me")
  bool remindAtMe;
  @JsonKey(name: "remind_chat_notice")
  bool remindChatNotice;
  @JsonKey(name: "new_fan")
  bool newFan;
  @JsonKey(name: "open_location")
  bool openLocation;

  UserPreference({
    required this.remindCommentNotice,
    required this.remindOfficialNotice,
    required this.remindAtMe,
    required this.remindChatNotice,
    required this.newFan,
    required this.openLocation,
  });

  factory UserPreference.fromJson(Map<String, dynamic> json) =>
      _$UserPreferenceFromJson(json);

  Map<String, dynamic> toJson() => _$UserPreferenceToJson(this);
}
