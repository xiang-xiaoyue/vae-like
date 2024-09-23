// To parse this JSON data, do
//
//     final payNote = payNoteFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'pay_note.g.dart';

PayNote payNoteFromJson(String str) => PayNote.fromJson(json.decode(str));

String payNoteToJson(PayNote data) => json.encode(data.toJson());

@JsonSerializable()
class PayNote {
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
  @JsonKey(name: "user_id")
  int userId;
  @JsonKey(name: "currency_type")
  String currencyType;
  @JsonKey(name: "currency_count")
  int currencyCount;
  @JsonKey(name: "post_id")
  int postId;
  @JsonKey(name: "post_count")
  int postCount;
  @JsonKey(name: "post_title")
  String postTitle;
  @JsonKey(name: "status")
  String status;

  PayNote({
    required this.id,
    required this.createTime,
    required this.deleteTime,
    required this.updateTime,
    required this.locationName,
    required this.userId,
    required this.currencyType,
    required this.currencyCount,
    required this.postId,
    required this.postCount,
    required this.postTitle,
    required this.status,
  });

  factory PayNote.fromJson(Map<String, dynamic> json) =>
      _$PayNoteFromJson(json);

  Map<String, dynamic> toJson() => _$PayNoteToJson(this);
}
