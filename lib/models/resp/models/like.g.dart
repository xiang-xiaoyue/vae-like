// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Like _$LikeFromJson(Map<String, dynamic> json) => Like(
      id: (json['id'] as num).toInt(),
      likedId: (json['liked_id'] as num).toInt(),
      createTime: (json['create_time'] as num).toInt(),
      likedType: json['liked_type'] as String,
      user: (json['user'] as num).toInt(),
      userAvatar: json['user_avatar'] as String,
      username: json['username'] as String,
      postId: (json['post_id'] as num).toInt(),
      content: json['content'] as String,
      authorId: (json['author_id'] as num).toInt(),
      authorName: json['author_name'] as String,
      imageUrl: json['image_url'] as String,
      publishTime: (json['publish_time'] as num).toInt(),
      replyCount: (json['reply_count'] as num).toInt(),
      floor: (json['floor'] as num).toInt(),
    );

Map<String, dynamic> _$LikeToJson(Like instance) => <String, dynamic>{
      'id': instance.id,
      'liked_id': instance.likedId,
      'create_time': instance.createTime,
      'liked_type': instance.likedType,
      'user': instance.user,
      'user_avatar': instance.userAvatar,
      'username': instance.username,
      'post_id': instance.postId,
      'content': instance.content,
      'author_id': instance.authorId,
      'author_name': instance.authorName,
      'image_url': instance.imageUrl,
      'publish_time': instance.publishTime,
      'reply_count': instance.replyCount,
      'floor': instance.floor,
    };
