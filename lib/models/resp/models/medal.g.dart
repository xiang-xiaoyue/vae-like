// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medal _$MedalFromJson(Map<String, dynamic> json) => Medal(
      id: (json['id'] as num).toInt(),
      isWearing: json['is_wearing'] as bool,
      createTime: (json['create_time'] as num).toInt(),
      deleteTime: (json['delete_time'] as num).toInt(),
      updateTime: (json['update_time'] as num).toInt(),
      locationName: json['location_name'] as String,
      startTime: (json['start_time'] as num).toInt(),
      endTime: (json['end_time'] as num).toInt(),
      name: json['name'] as String,
      imgUrl: json['img_url'] as String,
      criticalValue: (json['critical_value'] as num).toInt(),
      info: json['info'] as String,
      typeKey: json['type_key'] as String,
      type: json['type'] as String,
      isHolding: json['is_holding'] as bool,
      hasSufficientPower: json['has_sufficient_power'] as bool,
      requireDoneCount: (json['require_done_count'] as num).toInt(),
      doneCount: (json['done_count'] as num).toInt(),
    );

Map<String, dynamic> _$MedalToJson(Medal instance) => <String, dynamic>{
      'id': instance.id,
      'create_time': instance.createTime,
      'delete_time': instance.deleteTime,
      'update_time': instance.updateTime,
      'location_name': instance.locationName,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'name': instance.name,
      'img_url': instance.imgUrl,
      'critical_value': instance.criticalValue,
      'info': instance.info,
      'type_key': instance.typeKey,
      'type': instance.type,
      'is_holding': instance.isHolding,
      'has_sufficient_power': instance.hasSufficientPower,
      'require_done_count': instance.requireDoneCount,
      'done_count': instance.doneCount,
      'is_wearing': instance.isWearing,
    };
