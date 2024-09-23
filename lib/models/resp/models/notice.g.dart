// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notice _$NoticeFromJson(Map<String, dynamic> json) => Notice(
      id: (json['id'] as num).toInt(),
      createTime: (json['create_time'] as num).toInt(),
      deleteTime: (json['delete_time'] as num).toInt(),
      updateTime: (json['update_time'] as num).toInt(),
      locationName: json['location_name'] as String,
      userId: (json['user_id'] as num).toInt(),
      userAvatar: json['user_avatar'] as String,
      username: json['username'] as String,
      content: json['content'] as String,
      subjectFloor: (json['subject_floor'] as num).toInt(),
      subjectLikeCount: (json['subject_like_count'] as num).toInt(),
      objectImageUrl: json['object_image_url'] as String,
      ojbectDisplayName: json['ojbect_display_name'] as String,
      objectCreateTime: (json['object_create_time'] as num).toInt(),
      objectContent: json['object_content'] as String,
      objectReplyCount: (json['object_reply_count'] as num).toInt(),
      ojbectFloor: (json['ojbect_floor'] as num).toInt(),
      objectId: (json['object_id'] as num).toInt(),
      objectType: json['object_type'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      postId: (json['post_id'] as num).toInt(),
      objectAuthorId: (json['object_author_id'] as num).toInt(),
    );

Map<String, dynamic> _$NoticeToJson(Notice instance) => <String, dynamic>{
      'id': instance.id,
      'create_time': instance.createTime,
      'delete_time': instance.deleteTime,
      'update_time': instance.updateTime,
      'location_name': instance.locationName,
      'user_id': instance.userId,
      'user_avatar': instance.userAvatar,
      'username': instance.username,
      'content': instance.content,
      'subject_floor': instance.subjectFloor,
      'subject_like_count': instance.subjectLikeCount,
      'object_image_url': instance.objectImageUrl,
      'ojbect_display_name': instance.ojbectDisplayName,
      'object_create_time': instance.objectCreateTime,
      'object_content': instance.objectContent,
      'object_reply_count': instance.objectReplyCount,
      'ojbect_floor': instance.ojbectFloor,
      'object_id': instance.objectId,
      'object_type': instance.objectType,
      'type': instance.type,
      'status': instance.status,
      'post_id': instance.postId,
      'object_author_id': instance.objectAuthorId,
    };
