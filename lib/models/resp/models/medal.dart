// To parse this JSON data, do
//
//     final medal = medalFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'medal.g.dart';

Medal medalFromJson(String str) => Medal.fromJson(json.decode(str));

String medalToJson(Medal data) => json.encode(data.toJson());

@JsonSerializable()
class Medal {
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
  @JsonKey(name: "start_time")
  int startTime;
  @JsonKey(name: "end_time")
  int endTime;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "img_url")
  String imgUrl;
  @JsonKey(name: "critical_value")
  int criticalValue;
  @JsonKey(name: "info")
  String info;
  @JsonKey(name: "type_key")
  String typeKey;
  @JsonKey(name: "type")
  String type;
  @JsonKey(name: "is_holding")
  bool isHolding;
  @JsonKey(name: "has_sufficient_power")
  bool hasSufficientPower;
  @JsonKey(name: "require_done_count")
  int requireDoneCount;
  @JsonKey(name: "done_count")
  int doneCount;
  @JsonKey(name: "is_wearing")
  bool isWearing;

  Medal({
    required this.id,
    required this.isWearing,
    required this.createTime,
    required this.deleteTime,
    required this.updateTime,
    required this.locationName,
    required this.startTime,
    required this.endTime,
    required this.name,
    required this.imgUrl,
    required this.criticalValue,
    required this.info,
    required this.typeKey,
    required this.type,
    required this.isHolding,
    required this.hasSufficientPower,
    required this.requireDoneCount,
    required this.doneCount,
  });

  factory Medal.fromJson(Map<String, dynamic> json) => _$MedalFromJson(json);

  Map<String, dynamic> toJson() => _$MedalToJson(this);
}
