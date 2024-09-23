// To parse this JSON data, do
//
//     final taskNote = taskNoteFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:trump/models/resp/models/task.dart';

part 'task_note.g.dart';

TaskNote taskNoteFromJson(String str) => TaskNote.fromJson(json.decode(str));

String taskNoteToJson(TaskNote data) => json.encode(data.toJson());

@JsonSerializable()
class TaskNote {
  @JsonKey(name: "task")
  Task task;
  @JsonKey(name: "gain_reward")
  bool gainReward;
  @JsonKey(name: "done_count")
  int doneCount;

  TaskNote({
    required this.task,
    required this.gainReward,
    required this.doneCount,
  });

  factory TaskNote.fromJson(Map<String, dynamic> json) =>
      _$TaskNoteFromJson(json);

  Map<String, dynamic> toJson() => _$TaskNoteToJson(this);
}
