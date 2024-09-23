import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'msg.g.dart';

Msg msgFromJson(String str) => Msg.fromJson(json.decode(str));

String msgToJson(Msg data) => json.encode(data.toJson());

@JsonSerializable()
class Msg {
  @JsonKey(name: "id")
  int id;
//  @JsonKey(name: "message_type")
// String messageType;
  @JsonKey(name: "create_time")
  int createTime;
  @JsonKey(name: "delete_time")
  int deleteTime;
  @JsonKey(name: "update_time")
  int updateTime;
  @JsonKey(name: "location_name")
  String locationName;
  @JsonKey(name: "from_user_id")
  int fromUserId;
  @JsonKey(name: "to_user_id")
  int toUserId;
  @JsonKey(name: "group_id")
  int groupId;
  @JsonKey(name: "content")
  String content;
  @JsonKey(name: "content_type")
  String contentType;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "poster")
  String poster;
  @JsonKey(name: "url")
  String url;
  @JsonKey(name: "amount")
  int amount;

  Msg({
    required this.id,
//    required this.messageType,
    required this.createTime,
    required this.deleteTime,
    required this.updateTime,
    required this.locationName,
    required this.fromUserId,
    required this.toUserId,
    required this.groupId,
    required this.content,
    required this.contentType,
    required this.status,
    required this.poster,
    required this.url,
    required this.amount,
  });

  factory Msg.fromJson(Map<String, dynamic> json) => _$MsgFromJson(json);

  Map<String, dynamic> toJson() => _$MsgToJson(this);
}
