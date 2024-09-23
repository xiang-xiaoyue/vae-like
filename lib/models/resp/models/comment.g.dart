// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: (json['id'] as num).toInt(),
      atUserList: (json['at_user_list'] as List<dynamic>)
          .map((e) => (e as num?)?.toInt())
          .toList(),
      isLiking: json['is_liking'] as bool,
      createTime: (json['create_time'] as num).toInt(),
      deleteTime: (json['delete_time'] as num).toInt(),
      updateTime: (json['update_time'] as num).toInt(),
      locationName: json['location_name'] as String,
      content: json['content'] as String,
      picUrl: json['pic_url'] as String,
      voiceUrl: json['voice_url'] as String,
      postId: (json['post_id'] as num).toInt(),
      floorNumber: (json['floor_number'] as num).toInt(),
      parentId: (json['parent_id'] as num).toInt(),
      parent: json['parent'] == null
          ? null
          : Comment.fromJson(json['parent'] as Map<String, dynamic>),
      post: json['post'] == null
          ? null
          : Post.fromJson(json['post'] as Map<String, dynamic>),
      childCount: (json['child_count'] as num).toInt(),
      topId: (json['top_id'] as num).toInt(),
      likeCount: (json['like_count'] as num).toInt(),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'at_user_list': instance.atUserList,
      'is_liking': instance.isLiking,
      'create_time': instance.createTime,
      'delete_time': instance.deleteTime,
      'update_time': instance.updateTime,
      'location_name': instance.locationName,
      'content': instance.content,
      'pic_url': instance.picUrl,
      'voice_url': instance.voiceUrl,
      'post_id': instance.postId,
      'floor_number': instance.floorNumber,
      'parent_id': instance.parentId,
      'parent': instance.parent,
      'post': instance.post,
      'child_count': instance.childCount,
      'top_id': instance.topId,
      'like_count': instance.likeCount,
      'user': instance.user,
    };
