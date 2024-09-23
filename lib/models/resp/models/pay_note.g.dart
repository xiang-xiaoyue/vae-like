// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayNote _$PayNoteFromJson(Map<String, dynamic> json) => PayNote(
      id: (json['id'] as num).toInt(),
      createTime: (json['create_time'] as num).toInt(),
      deleteTime: (json['delete_time'] as num).toInt(),
      updateTime: (json['update_time'] as num).toInt(),
      locationName: json['location_name'] as String,
      userId: (json['user_id'] as num).toInt(),
      currencyType: json['currency_type'] as String,
      currencyCount: (json['currency_count'] as num).toInt(),
      postId: (json['post_id'] as num).toInt(),
      postCount: (json['post_count'] as num).toInt(),
      postTitle: json['post_title'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$PayNoteToJson(PayNote instance) => <String, dynamic>{
      'id': instance.id,
      'create_time': instance.createTime,
      'delete_time': instance.deleteTime,
      'update_time': instance.updateTime,
      'location_name': instance.locationName,
      'user_id': instance.userId,
      'currency_type': instance.currencyType,
      'currency_count': instance.currencyCount,
      'post_id': instance.postId,
      'post_count': instance.postCount,
      'post_title': instance.postTitle,
      'status': instance.status,
    };
