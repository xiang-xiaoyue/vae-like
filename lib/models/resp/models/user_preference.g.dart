// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreference _$UserPreferenceFromJson(Map<String, dynamic> json) =>
    UserPreference(
      remindCommentNotice: json['remind_comment_notice'] as bool,
      remindOfficialNotice: json['remind_official_notice'] as bool,
      remindAtMe: json['remind_at_me'] as bool,
      remindChatNotice: json['remind_chat_notice'] as bool,
      newFan: json['new_fan'] as bool,
      openLocation: json['open_location'] as bool,
    );

Map<String, dynamic> _$UserPreferenceToJson(UserPreference instance) =>
    <String, dynamic>{
      'remind_comment_notice': instance.remindCommentNotice,
      'remind_official_notice': instance.remindOfficialNotice,
      'remind_at_me': instance.remindAtMe,
      'remind_chat_notice': instance.remindChatNotice,
      'new_fan': instance.newFan,
      'open_location': instance.openLocation,
    };
