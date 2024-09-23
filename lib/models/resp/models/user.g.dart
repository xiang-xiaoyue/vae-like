// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      roles: (json['roles'] as List<dynamic>).map((e) => e as String?).toList(),
      likeCount: (json['like_count'] as num).toInt(),
      seriesCheckinDays: (json['series_checkin_days'] as num).toInt(),
      totalCheckinDays: (json['total_checkin_days'] as num).toInt(),
      isFollowing: json['is_following'] as bool,
      isLiking: json['is_liking'] as bool,
      isBlocking: json['is_blocking'] as bool,
      currency: Map<String, int>.from(json['currency'] as Map),
      createTime: (json['create_time'] as num).toInt(),
      deleteTime: (json['delete_time'] as num).toInt(),
      updateTime: (json['update_time'] as num).toInt(),
      locationName: json['location_name'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      age: (json['age'] as num).toInt(),
      gender: json['gender'] as String,
      avatarUrl: json['avatar_url'] as String,
      birthday: (json['birthday'] as num).toInt(),
      sign: json['sign'] as String,
      level: (json['level'] as num).toInt(),
      progress: (json['progress'] as num).toInt(),
      fanCount: (json['fan_count'] as num).toInt(),
      followingUserCount: (json['following_user_count'] as num).toInt(),
      friendCount: (json['friend_count'] as num).toInt(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'roles': instance.roles,
      'is_blocking': instance.isBlocking,
      'like_count': instance.likeCount,
      'series_checkin_days': instance.seriesCheckinDays,
      'total_checkin_days': instance.totalCheckinDays,
      'is_following': instance.isFollowing,
      'is_liking': instance.isLiking,
      'currency': instance.currency,
      'create_time': instance.createTime,
      'delete_time': instance.deleteTime,
      'update_time': instance.updateTime,
      'location_name': instance.locationName,
      'name': instance.name,
      'password': instance.password,
      'phone': instance.phone,
      'email': instance.email,
      'age': instance.age,
      'gender': instance.gender,
      'avatar_url': instance.avatarUrl,
      'birthday': instance.birthday,
      'sign': instance.sign,
      'level': instance.level,
      'progress': instance.progress,
      'fan_count': instance.fanCount,
      'following_user_count': instance.followingUserCount,
      'friend_count': instance.friendCount,
    };
