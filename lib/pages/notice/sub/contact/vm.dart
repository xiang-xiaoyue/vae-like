import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/group_simple.dart';
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/service/api.dart';

class ContactViewModel with ChangeNotifier {
  ContactViewModel() {
    getFriends();
    getEnteredGroups();
  }
  String kw = '';
  List<User> users = [];
  List<User> friends = [];
  // 群列表
  List<GroupSimple> groups = [];
  List<GroupSimple> filteredGroups = [];

  // 加载好友
  Future getFriends() async {
    ListResp listResp = await Api.instance.searchWithKeyword("", "friend");
    friends.clear();
    listResp.list?.forEach((i) => friends.add(User.fromJson(i)));
    notifyListeners();
  }

  // 根据关键字查询用户列表
  // todo:应当返回全部好友，前端根据关键字过滤
  Future getUserList(String keyword) async {
    kw = keyword;
    ListResp listResp =
        await Api.instance.searchWithKeyword(kw, Constants.searchTypeUser);
    users.clear();
    listResp.list?.forEach((i) {
      users.add(User.fromJson(i));
    });
    notifyListeners();
  }

  // 加好友
  Future addFriend(User user) async {
    bool success = await Api.instance.createFollow("user", user.id);
    if (success == true) {
      user.isFollowing = true;
    }
    notifyListeners();
  }

  // 加载全部已加入的群组
  Future getEnteredGroups() async {
    ListResp listResp = await Api.instance.getGroupList(isEntered: true);
    listResp.list?.forEach((i) {
      groups.add(GroupSimple.fromJson(i));
    });
    filterGroups("");
    notifyListeners();
  }

  // 根据关键字过滤已加入的群
  void filterGroups(String k) {
    if (k.isNotEmpty) {
      filteredGroups = groups.where((i) {
        return i.name.contains(k) || i.brief.contains(k);
      }).toList();
      notifyListeners();
    } else {
      filteredGroups = groups;
      notifyListeners();
    }
  }
}
