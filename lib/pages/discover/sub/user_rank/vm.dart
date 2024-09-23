import 'package:flutter/material.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/service/api.dart';

class UserRankIndexViewModel with ChangeNotifier {
  UserRankIndexViewModel() {
    getUserList();
  }
  List<User> hotUsers = []; // 人气榜
  List<User> checkinUsers = []; // 签到榜
  List<User> levelUsers = []; //等级榜
  List<User> coinUsers = []; // 金币榜

  Future getUserList() async {
    await _getList("hot");
    await _getList("coin");
    await _getList("level");
    await _getList("checkin");
    notifyListeners();
  }

  Future _getList(String type) async {
    ListResp listResp = await Api.instance
        .getRankList(entityType: "user", type: "hot", rate: "day");
    switch (type) {
      case "hot":
        hotUsers.clear();
        listResp.list?.forEach((i) {
          hotUsers.add(User.fromJson(i));
        });
        break;
      case "level":
        levelUsers.clear();
        listResp.list?.forEach((i) {
          levelUsers.add(User.fromJson(i));
        });
        break;
      case "checkin":
        checkinUsers.clear();
        listResp.list?.forEach((i) {
          checkinUsers.add(User.fromJson(i));
        });
        break;
      case "coin":
        coinUsers.clear();
        listResp.list?.forEach((i) {
          coinUsers.add(User.fromJson(i));
        });
        break;
      default:
        break;
    }
  }
}
