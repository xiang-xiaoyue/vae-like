// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'task.g.dart';

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

@JsonSerializable()
class Task {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "create_time")
  int createTime;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "display_name")
  String displayName;
  @JsonKey(name: "require_count")
  int requireCount;
  @JsonKey(name: "currency_type")
  String currencyType;
  @JsonKey(name: "currency_count")
  int currencyCount;

  Task({
    required this.id,
    required this.createTime,
    required this.name,
    required this.displayName,
    required this.requireCount,
    required this.currencyType,
    required this.currencyCount,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
