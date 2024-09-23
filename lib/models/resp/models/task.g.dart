// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: (json['id'] as num).toInt(),
      createTime: (json['create_time'] as num).toInt(),
      name: json['name'] as String,
      displayName: json['display_name'] as String,
      requireCount: (json['require_count'] as num).toInt(),
      currencyType: json['currency_type'] as String,
      currencyCount: (json['currency_count'] as num).toInt(),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'create_time': instance.createTime,
      'name': instance.name,
      'display_name': instance.displayName,
      'require_count': instance.requireCount,
      'currency_type': instance.currencyType,
      'currency_count': instance.currencyCount,
    };
