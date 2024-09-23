// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) => Subject(
      id: (json['id'] as num).toInt(),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      followingUserCount: (json['following_user_count'] as num).toInt(),
      isFollowing: json['is_following'] as bool,
      createTime: (json['create_time'] as num).toInt(),
      deleteTime: (json['delete_time'] as num).toInt(),
      updateTime: (json['update_time'] as num).toInt(),
      locationName: json['location_name'] as String,
      name: json['name'] as String,
      userId: (json['user_id'] as num).toInt(),
      keywords: json['keywords'] as String,
      summary: json['summary'] as String,
      reason: json['reason'] as String,
      coverUrlList: json['cover_url_list'] as String,
    );

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'following_user_count': instance.followingUserCount,
      'is_following': instance.isFollowing,
      'create_time': instance.createTime,
      'delete_time': instance.deleteTime,
      'update_time': instance.updateTime,
      'location_name': instance.locationName,
      'name': instance.name,
      'user_id': instance.userId,
      'keywords': instance.keywords,
      'summary': instance.summary,
      'reason': instance.reason,
      'cover_url_list': instance.coverUrlList,
    };
