// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_privacy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPrivacy _$UserPrivacyFromJson(Map<String, dynamic> json) => UserPrivacy(
      visitThread: json['visit_thread'] as String,
      sendPrivateMsgToMe: json['send_private_msg_to_me'] as String,
      visitFollowingAndFans: json['visit_following_and_fans'] as String,
      visitDistanceFromMe: json['visit_distance_from_me'] as String,
      visitMyLastLoginTime: json['visit_my_last_login_time'] as String,
    );

Map<String, dynamic> _$UserPrivacyToJson(UserPrivacy instance) =>
    <String, dynamic>{
      'visit_thread': instance.visitThread,
      'send_private_msg_to_me': instance.sendPrivateMsgToMe,
      'visit_following_and_fans': instance.visitFollowingAndFans,
      'visit_distance_from_me': instance.visitDistanceFromMe,
      'visit_my_last_login_time': instance.visitMyLastLoginTime,
    };
