import 'package:flutter/material.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/service/api.dart';

class SearchUserViewModel with ChangeNotifier {
  String keyword = '';
  int userCount = 0;
  List<User> userList = [];

  Future getUserListWithKeyword() async {
    ListResp listResp =
        await Api.instance.searchWithKeyword(keyword, Constants.searchTypeUser);
    userCount = listResp.count ?? 0;
    // 有锚则不清空
    userList.clear();
    listResp.list?.forEach((item) {
      userList.add(User.fromJson(item));
    });
    notifyListeners();
  }
}
