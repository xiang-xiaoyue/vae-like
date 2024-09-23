// To parse this JSON data, do
//
//     final voteResultItem = voteResultItemFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'vote_result_item.g.dart';

VoteResultItem voteResultItemFromJson(String str) =>
    VoteResultItem.fromJson(json.decode(str));

String voteResultItemToJson(VoteResultItem data) => json.encode(data.toJson());

@JsonSerializable()
class VoteResultItem {
  @JsonKey(name: "order")
  int order;
  @JsonKey(name: "content")
  String content;
  @JsonKey(name: "vote_count")
  int voteCount;
  @JsonKey(name: "is_voted")
  bool isVoted;
  @JsonKey(name: "vote_option_id")
  int voteOptionId;

  VoteResultItem({
    required this.order,
    required this.content,
    required this.voteCount,
    required this.isVoted,
    required this.voteOptionId,
  });

  factory VoteResultItem.fromJson(Map<String, dynamic> json) =>
      _$VoteResultItemFromJson(json);

  Map<String, dynamic> toJson() => _$VoteResultItemToJson(this);
}
