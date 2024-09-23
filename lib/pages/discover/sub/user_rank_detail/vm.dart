import 'package:flutter/material.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/service/api.dart';

class RankDetailViewModel with ChangeNotifier {
  RankDetailViewModel(String type) {
    getUserList(type);
  }

  List<User> users = [];

  static const String userRankTypeHot = "hot";
  static const String userRankTypeLevel = "level";
  static const String userRankTypeCheckin = "checkin";
  static const String userRankTypeCoin = "coin";

  Future getUserList(String type) async {
    ListResp listResp =
        await Api.instance.getRankList(type: type, entityType: "user");
    users.clear();
    listResp.list?.forEach((i) {
      users.add(User.fromJson(i));
    });
    notifyListeners();
  }
}
