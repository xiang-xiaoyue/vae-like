// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewPost _$NewPostFromJson(Map<String, dynamic> json) => NewPost(
      title: json['title'] as String? ?? '',
      id: (json['id'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? "normal",
      color: json['color'] as String? ?? '0xffffffff',
      content: json['content'] as String? ?? '',
      subjectId: (json['subject_id'] as num?)?.toInt() ?? 0,
      startTime: (json['start_time'] as num?)?.toInt() ?? 0,
      endTime: (json['end_time'] as num?)?.toInt() ?? 0,
      imageList: (json['image_list'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      posterUrl: json['poster_url'] as String? ?? '',
      videoUrl: json['video_url'] as String? ?? '',
      voiceUrl: json['voice_url'] as String? ?? '',
      musicUrl: json['music_url'] as String? ?? '',
      atUserList: (json['at_user_list'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      type: json['type'] as String? ?? '',
      subType: json['sub_type'] as String? ?? '',
    )..voteOptionList = (json['vote_option_list'] as List<dynamic>)
        .map((e) => e as String)
        .toList();

Map<String, dynamic> _$NewPostToJson(NewPost instance) => <String, dynamic>{
      'title': instance.title,
      'status': instance.status,
      'vote_option_list': instance.voteOptionList,
      'color': instance.color,
      'content': instance.content,
      'subject_id': instance.subjectId,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'image_list': instance.imageList,
      'poster_url': instance.posterUrl,
      'video_url': instance.videoUrl,
      'voice_url': instance.voiceUrl,
      'music_url': instance.musicUrl,
      'at_user_list': instance.atUserList,
      'type': instance.type,
      'sub_type': instance.subType,
      'id': instance.id,
    };
