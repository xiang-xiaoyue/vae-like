import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/service/api.dart';

class InviteViewModel with ChangeNotifier {
  InviteViewModel() {
    getInviter();
    getInvitedCount();
  }
  String code = ""; // 对方的邀请码 (id)
  User? inviter; //code对应的用户，邀请者
  int beInvitedCount = 0;

  // 输入邀请码，被邀请
  Future beInvited() async {
    bool success = await Api.instance.beInvited(code);
    if (success == true) {
      inviter = await Api.instance.getUserInfo(code.toString());
    }
    notifyListeners();
  }

  // 加载邀请者
  Future getInviter() async {
    inviter = await Api.instance.getInviter();
    notifyListeners();
  }

  // 查询自己邀请了哪些人
  Future getInvitedCount() async {
    ListResp listResp = await Api.instance.getBeInvitedUserList();
    beInvitedCount = listResp.count ?? 0;
    notifyListeners();
  }
}
