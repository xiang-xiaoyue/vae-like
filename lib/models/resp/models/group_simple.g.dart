// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_simple.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupSimple _$GroupSimpleFromJson(Map<String, dynamic> json) => GroupSimple(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      cover: json['cover'] as String,
      brief: json['brief'] as String,
      capacity: (json['capacity'] as num).toInt(),
      memberCount: (json['member_count'] as num).toInt(),
    );

Map<String, dynamic> _$GroupSimpleToJson(GroupSimple instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cover': instance.cover,
      'brief': instance.brief,
      'capacity': instance.capacity,
      'member_count': instance.memberCount,
    };
