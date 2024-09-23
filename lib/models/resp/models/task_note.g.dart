// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskNote _$TaskNoteFromJson(Map<String, dynamic> json) => TaskNote(
      task: Task.fromJson(json['task'] as Map<String, dynamic>),
      gainReward: json['gain_reward'] as bool,
      doneCount: (json['done_count'] as num).toInt(),
    );

Map<String, dynamic> _$TaskNoteToJson(TaskNote instance) => <String, dynamic>{
      'task': instance.task,
      'gain_reward': instance.gainReward,
      'done_count': instance.doneCount,
    };
