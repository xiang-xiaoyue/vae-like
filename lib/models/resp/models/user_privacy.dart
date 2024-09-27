// To parse this JSON data, do
//
//     final userPrivacy = userPrivacyFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'user_privacy.g.dart';

UserPrivacy userPrivacyFromJson(String str) =>
    UserPrivacy.fromJson(json.decode(str));

String userPrivacyToJson(UserPrivacy data) => json.encode(data.toJson());

@JsonSerializable()
class UserPrivacy {
  @JsonKey(name: "visit_thread")
  String visitThread;
  @JsonKey(name: "send_private_msg_to_me")
  String sendPrivateMsgToMe;
  @JsonKey(name: "visit_following_and_fans")
  String visitFollowingAndFans;
  @JsonKey(name: "visit_distance_from_me")
  String visitDistanceFromMe;
  @JsonKey(name: "visit_my_last_login_time")
  String visitMyLastLoginTime;

  UserPrivacy({
    required this.visitThread,
    required this.sendPrivateMsgToMe,
    required this.visitFollowingAndFans,
    required this.visitDistanceFromMe,
    required this.visitMyLastLoginTime,
  });

  factory UserPrivacy.fromJson(Map<String, dynamic> json) =>
      _$UserPrivacyFromJson(json);

  Map<String, dynamic> toJson() => _$UserPrivacyToJson(this);
}
