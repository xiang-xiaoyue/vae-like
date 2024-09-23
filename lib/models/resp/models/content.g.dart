// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      createTime: (json['create_time'] as num).toInt(),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      type: json['type'] as String,
      picUrl: json['pic_url'] as String,
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'create_time': instance.createTime,
      'user': instance.user,
      'type': instance.type,
      'pic_url': instance.picUrl,
    };
