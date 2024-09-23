import 'package:flutter/material.dart';
import 'package:trump/models/resp/models/group.dart';
import 'package:trump/service/api.dart';

class GroupDetailViewModel with ChangeNotifier {
  GroupDetailViewModel(String id) {
    getGroup(id);
  }
  Group? group;

  Future getGroup(String id) async {
    group = await Api.instance.getGroupDetail(id);
    print("返回的群数据：${group?.name}");
    notifyListeners();
  }

  // 进群或 退群
  Future toggleInGroup() async {
    bool success = false;
    if (group!.inGroup) {
      // 退群
      success = await Api.instance.leaveGroup(group!.id);
    } else {
      // 进群
      success = await Api.instance.enterGroup(group!.id);
    }
    if (success == true) {
      group!.inGroup = !group!.inGroup;
      notifyListeners();
    }
    return success;
  }
}
