import 'package:flutter/material.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/service/api.dart';

class BlacklistViewModel with ChangeNotifier {
  BlacklistViewModel(int uid) {
    getBlacklist(uid);
  }
  // 黑名单用户列表
  List<User> users = [];

  Future getBlacklist(int uid) async {
    ListResp listResp = await Api.instance.getBlacklist(uid);
    users.clear();
    listResp.list?.forEach((i) {
      users.add(User.fromJson(i));
    });
    notifyListeners();
  }

  // 移出黑名单
  Future removeFromBlacklist(User user) async {
    bool success = await Api.instance.cancelBlock(user.id);
    if (success == true) {
      users.remove(user);
    }
    notifyListeners();
  }
}
