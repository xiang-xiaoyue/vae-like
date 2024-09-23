// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Checkin _$CheckinFromJson(Map<String, dynamic> json) => Checkin(
      userId: (json['user_id'] as num).toInt(),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => CheckinItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      seriesCheckinDays: (json['series_checkin_days'] as num).toInt(),
      totalCheckinDays: (json['total_checkin_days'] as num).toInt(),
    );

Map<String, dynamic> _$CheckinToJson(Checkin instance) => <String, dynamic>{
      'user_id': instance.userId,
      'items': instance.items,
      'series_checkin_days': instance.seriesCheckinDays,
      'total_checkin_days': instance.totalCheckinDays,
    };

CheckinItem _$CheckinItemFromJson(Map<String, dynamic> json) => CheckinItem(
      id: (json['id'] as num).toInt(),
      createTime: (json['create_time'] as num).toInt(),
      date: json['date'] as String,
    );

Map<String, dynamic> _$CheckinItemToJson(CheckinItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'create_time': instance.createTime,
      'date': instance.date,
    };
