// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'msg.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Msg _$MsgFromJson(Map<String, dynamic> json) => Msg(
      id: (json['id'] as num).toInt(),
      createTime: (json['create_time'] as num).toInt(),
      deleteTime: (json['delete_time'] as num).toInt(),
      updateTime: (json['update_time'] as num).toInt(),
      locationName: json['location_name'] as String,
      fromUserId: (json['from_user_id'] as num).toInt(),
      toUserId: (json['to_user_id'] as num).toInt(),
      groupId: (json['group_id'] as num).toInt(),
      content: json['content'] as String,
      contentType: json['content_type'] as String,
      status: json['status'] as String,
      poster: json['poster'] as String,
      url: json['url'] as String,
      amount: (json['amount'] as num).toInt(),
    );

Map<String, dynamic> _$MsgToJson(Msg instance) => <String, dynamic>{
      'id': instance.id,
      'create_time': instance.createTime,
      'delete_time': instance.deleteTime,
      'update_time': instance.updateTime,
      'location_name': instance.locationName,
      'from_user_id': instance.fromUserId,
      'to_user_id': instance.toUserId,
      'group_id': instance.groupId,
      'content': instance.content,
      'content_type': instance.contentType,
      'status': instance.status,
      'poster': instance.poster,
      'url': instance.url,
      'amount': instance.amount,
    };
