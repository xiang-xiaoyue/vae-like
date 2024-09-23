import 'package:json_annotation/json_annotation.dart';
import 'package:trump/models/resp/models/user.dart';
import 'dart:convert';

part 'group_simple.g.dart';

GroupSimple groupSimpleFromJson(String str) =>
    GroupSimple.fromJson(json.decode(str));

String groupSimpleToJson(GroupSimple data) => json.encode(data.toJson());

@JsonSerializable()
class GroupSimple {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "cover")
  String cover;
  @JsonKey(name: "brief")
  String brief;
  @JsonKey(name: "capacity")
  int capacity;
  @JsonKey(name: "member_count")
  int memberCount;

  GroupSimple({
    required this.id,
    required this.name,
    required this.cover,
    required this.brief,
    required this.capacity,
    required this.memberCount,
  });

  factory GroupSimple.fromJson(Map<String, dynamic> json) =>
      _$GroupSimpleFromJson(json);

  Map<String, dynamic> toJson() => _$GroupSimpleToJson(this);
}
