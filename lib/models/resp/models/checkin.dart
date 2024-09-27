// To parse this JSON data, do
//
//     final checkin = checkinFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'checkin.g.dart';

Checkin checkinFromJson(String str) => Checkin.fromJson(json.decode(str));

String checkinToJson(Checkin data) => json.encode(data.toJson());

@JsonSerializable()
class Checkin {
  @JsonKey(name: "user_id")
  int userId;
  @JsonKey(name: "items")
  List<CheckinItem>? items;
  @JsonKey(name: "series_checkin_days")
  int seriesCheckinDays;
  @JsonKey(name: "total_checkin_days")
  int totalCheckinDays;

  Checkin({
    required this.userId,
    required this.items,
    required this.seriesCheckinDays,
    required this.totalCheckinDays,
  });

  factory Checkin.fromJson(Map<String, dynamic> json) =>
      _$CheckinFromJson(json);

  Map<String, dynamic> toJson() => _$CheckinToJson(this);
}

@JsonSerializable()
class CheckinItem {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "create_time")
  int createTime;
  @JsonKey(name: "date")
  String date;

  CheckinItem({
    required this.id,
    required this.createTime,
    required this.date,
  });

  factory CheckinItem.fromJson(Map<String, dynamic> json) =>
      _$CheckinItemFromJson(json);

  Map<String, dynamic> toJson() => _$CheckinItemToJson(this);
}
