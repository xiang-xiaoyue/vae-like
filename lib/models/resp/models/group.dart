// To parse this JSON data, do
//
//     final group = groupFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import './user.dart';
import 'dart:convert';

part 'group.g.dart';

Group groupFromJson(String str) => Group.fromJson(json.decode(str));

String groupToJson(Group data) => json.encode(data.toJson());

@JsonSerializable()
class Group {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "create_time")
  int createTime;
  @JsonKey(name: "delete_time")
  int deleteTime;
  @JsonKey(name: "update_time")
  int updateTime;
  @JsonKey(name: "location_name")
  String locationName;
  @JsonKey(name: "user")
  User user;
  @JsonKey(name: "warden_list")
  List<User>? wardenList;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "cover")
  String cover;
  @JsonKey(name: "brief")
  String brief;
  @JsonKey(name: "bulletin")
  String bulletin;
  @JsonKey(name: "capacity")
  int capacity;
  @JsonKey(name: "member_count")
  int memberCount;
  @JsonKey(name: "members")
  List<User>? members;
  @JsonKey(name: "in_group")
  bool inGroup;

  Group({
    required this.id,
    required this.createTime,
    required this.deleteTime,
    required this.updateTime,
    required this.locationName,
    required this.user,
    required this.wardenList,
    required this.name,
    required this.cover,
    required this.brief,
    required this.bulletin,
    required this.capacity,
    required this.memberCount,
    required this.members,
    required this.inGroup,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
