// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_result_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoteResultItem _$VoteResultItemFromJson(Map<String, dynamic> json) =>
    VoteResultItem(
      order: (json['order'] as num).toInt(),
      content: json['content'] as String,
      voteCount: (json['vote_count'] as num).toInt(),
      isVoted: json['is_voted'] as bool,
      voteOptionId: (json['vote_option_id'] as num).toInt(),
    );

Map<String, dynamic> _$VoteResultItemToJson(VoteResultItem instance) =>
    <String, dynamic>{
      'order': instance.order,
      'content': instance.content,
      'vote_count': instance.voteCount,
      'is_voted': instance.isVoted,
      'vote_option_id': instance.voteOptionId,
    };
