import 'package:flutter/material.dart';

// 全局信息
class GlobalViewModel with ChangeNotifier {
  int curIdx = 0; // 底部菜单当前索引
  List<int> historyIdList = []; // 跳转到新页面时，保留之前的页面索引

  void setCurIdx(int idx) {
    historyIdList.add(curIdx);
    curIdx = idx;
    notifyListeners();
  }

  void popIdx() {
    curIdx = historyIdList.removeLast();
    notifyListeners();
  }
}

// class Task {
//   // 例：在线30(requiredCount)分钟获得经验值(rewardExpCount)10点和金币(rewardCoinCount)50枚，已经在线(doneCount)10分钟.
//   String name; // 任务名
//   int requiredCount; // 要求完成的任务量
//   int doneCount; // 已经完成的任务量
//   int rewardCoinCount; // 完成任务奖励金币数量
//   int rewardExpCount; // 完成任务奖励积分数量
//   bool isDone; // 这是冗余的字段
//
//   Task({
//     required this.name,
//     required this.requiredCount,
//     required this.doneCount,
//     required this.rewardCoinCount,
//     required this.rewardExpCount,
//     this.isDone = false,
//   });
// }
//

//List<Task> tasks = []; // 当前登录用户的任务列表

// 当前用户关注着的话题id

// 获取当前用户相关信息
// 当前用户更新信息

//}
