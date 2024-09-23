import 'package:flutter/material.dart';
import 'package:trump/service/api.dart';

class DiscoverViewModel with ChangeNotifier {
  DiscoverViewModel() {
    getCheckinStatus();
    getTaskProgress();
  }
  bool isCheckedIn = false;
  int taskProgress = 0;

  Future getCheckinStatus() async {
    isCheckedIn = await Api.instance.todayIsCheckedIn();
    notifyListeners();
  }

  // 任务完成进度
  Future getTaskProgress() async {
    taskProgress = await Api.instance.getTaskProgress();
    notifyListeners();
  }
}
