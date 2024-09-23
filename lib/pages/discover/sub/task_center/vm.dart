import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/task.dart';
import 'package:trump/models/resp/models/task_note.dart';
import 'package:trump/service/api.dart';

// todo:当前把“签到”也加进来了
class TaskCenterViewModel with ChangeNotifier {
  List<TaskNote> notes = [];
  List<TaskNote> tasknotes = [];
  List<Task> tasks = [];
  TaskCenterViewModel() {
    getNoteList().then((_) {
      getTaskList().then((_) {
        buildTaskNoteList();
        Timer.periodic(Duration(seconds: 60), (t) {
          // 在此界面每一分钟获取一次信息
          getNoteList();
          getTaskList();
          buildTaskNoteList();
        });
      });
    });
  }

  // 整理今日任务列表
  void buildTaskNoteList() async {
    List<int> ids = tasknotes.map((tn) => tn.task.id).toList();
    notes.clear();
    for (var task in tasks) {
      if (ids.contains(task.id)) {
        notes.add(tasknotes.firstWhere((tn) {
          return tn.task.id == task.id;
        }));
        notifyListeners();
      } else {
        notes.add(TaskNote(task: task, gainReward: false, doneCount: 0));
        notifyListeners();
      }
      notifyListeners();
    }
    notes.sort((a, b) {
      return a.task.id - b.task.id;
    });
    notifyListeners();
  }

  // 获取今天的任务记录(tasknote)
  Future getNoteList() async {
    ListResp listResp = await Api.instance.getTodayTaskNoteList();
    tasknotes.clear();
    if (listResp.list != null && listResp.list!.isNotEmpty) {
      for (var i in listResp.list!) {
        tasknotes.add(TaskNote.fromJson(i));
      }
      notifyListeners();
    }
  }

  // 获取全部任务task
  Future getTaskList() async {
    ListResp listResp = await Api.instance.getAllTask();
    tasks.clear();
    if (listResp.list != null && listResp.list!.isNotEmpty) {
      listResp.list?.forEach((i) {
        tasks.add(Task.fromJson(i));
      });
      notifyListeners();
    }
  }

  // 领取任务奖励
  Future<bool> gainTaskReward(int taskID) async {
    bool success = await Api.instance.getTaskReward(taskID);
    if (success == true) {
      for (var i in notes) {
        i.task.id == taskID ? i.gainReward = true : null;
      }
      getNoteList();
      buildTaskNoteList();
      notifyListeners();
    }
    return success;
  }
}
