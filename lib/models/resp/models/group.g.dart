// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      id: (json['id'] as num).toInt(),
      createTime: (json['create_time'] as num).toInt(),
      deleteTime: (json['delete_time'] as num).toInt(),
      updateTime: (json['update_time'] as num).toInt(),
      locationName: json['location_name'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      wardenList: (json['warden_list'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String,
      cover: json['cover'] as String,
      brief: json['brief'] as String,
      bulletin: json['bulletin'] as String,
      capacity: (json['capacity'] as num).toInt(),
      memberCount: (json['member_count'] as num).toInt(),
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      inGroup: json['in_group'] as bool,
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'id': instance.id,
      'create_time': instance.createTime,
      'delete_time': instance.deleteTime,
      'update_time': instance.updateTime,
      'location_name': instance.locationName,
      'user': instance.user,
      'warden_list': instance.wardenList,
      'name': instance.name,
      'cover': instance.cover,
      'brief': instance.brief,
      'bulletin': instance.bulletin,
      'capacity': instance.capacity,
      'member_count': instance.memberCount,
      'members': instance.members,
      'in_group': instance.inGroup,
    };
