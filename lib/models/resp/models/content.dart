// To parse this JSON data, do
//
//     final content = contentFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import './user.dart';
import 'dart:convert';

part 'content.g.dart';

Content contentFromJson(String str) => Content.fromJson(json.decode(str));

String contentToJson(Content data) => json.encode(data.toJson());

@JsonSerializable()
class Content {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "content")
  String content;
  @JsonKey(name: "create_time")
  int createTime;
  @JsonKey(name: "user")
  User user;
  @JsonKey(name: "type")
  String type;
  @JsonKey(name: "pic_url")
  String picUrl;

  Content({
    required this.id,
    required this.title,
    required this.content,
    required this.createTime,
    required this.user,
    required this.type,
    required this.picUrl,
  });

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
