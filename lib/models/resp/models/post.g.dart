// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: (json['id'] as num).toInt(),
      currencyType: json['currency_type'] as String,
      currencyCount: (json['currency_count'] as num).toInt(),
      voteResult: (json['vote_result'] as List<dynamic>?)
          ?.map((e) => VoteResultItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      color: json['color'] as String,
      createTime: (json['create_time'] as num).toInt(),
      deleteTime: (json['delete_time'] as num).toInt(),
      updateTime: (json['update_time'] as num).toInt(),
      locationName: json['location_name'] as String,
      userId: (json['user_id'] as num).toInt(),
      likeCount: (json['like_count'] as num).toInt(),
      commentCount: (json['comment_count'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      subject: Subject.fromJson(json['subject'] as Map<String, dynamic>),
      startTime: (json['start_time'] as num).toInt(),
      endTime: (json['end_time'] as num).toInt(),
      isGlory: json['is_glory'] as bool,
      viewCount: (json['view_count'] as num).toInt(),
      imageList: (json['image_list'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      posterUrl: json['poster_url'] as String,
      videoUrl: json['video_url'] as String,
      voiceUrl: json['voice_url'] as String,
      musicUrl: json['music_url'] as String,
      atUserList: (json['at_user_list'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      type: json['type'] as String,
      subType: json['sub_type'] as String,
      isLiking: json['is_liking'] as bool,
      isCollecting: json['is_collecting'] as bool,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'currency_type': instance.currencyType,
      'currency_count': instance.currencyCount,
      'vote_result': instance.voteResult,
      'create_time': instance.createTime,
      'color': instance.color,
      'delete_time': instance.deleteTime,
      'update_time': instance.updateTime,
      'location_name': instance.locationName,
      'user_id': instance.userId,
      'like_count': instance.likeCount,
      'comment_count': instance.commentCount,
      'title': instance.title,
      'content': instance.content,
      'subject': instance.subject,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'is_glory': instance.isGlory,
      'view_count': instance.viewCount,
      'image_list': instance.imageList,
      'poster_url': instance.posterUrl,
      'video_url': instance.videoUrl,
      'voice_url': instance.voiceUrl,
      'music_url': instance.musicUrl,
      'at_user_list': instance.atUserList,
      'type': instance.type,
      'sub_type': instance.subType,
      'is_liking': instance.isLiking,
      'is_collecting': instance.isCollecting,
      'user': instance.user,
    };
