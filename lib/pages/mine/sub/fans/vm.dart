import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/service/api.dart';

// 进入页面就查询所有粉丝和关注着的用户，根据搜索框输入内容过滤
class FansPageViewModel with ChangeNotifier {
  FansPageViewModel(int uid) {
    curUserId = uid;
    getFollowingUser();
    getFans();
  }
  String keyword = '';
  int curUserId = 0;
  List<User> fans = [];
  List<User> followingUsers = [];

  Future getFollowingUser() async {
    ListResp listResp = await Api.instance.getFollowingList("user", curUserId);
    followingUsers.clear();
    listResp.list?.forEach((item) {
      followingUsers.add(User.fromJson(item));
    });

    notifyListeners();
  }

  Future getFans() async {
    ListResp listResp = await Api.instance.getFans("user", curUserId);
    fans.clear();
    listResp.list?.forEach((item) {
      fans.add(User.fromJson(item));
    });
    notifyListeners();
  }

  Future filterFans(String kw) async {
    if (kw != keyword) {
      await getFans();
    }
    keyword = kw;
    fans.removeWhere(
        (fan) => !fan.name.contains(kw) && !kw.contains(fan.id.toString()));
    notifyListeners();
  }

  // 取消关注或关注fan
  Future toggleFollowFan(User fan) async {
    bool success;
    if (fan.isFollowing) {
      // "我"关注着这个粉丝，现在取关
      success = await Api.instance.deleteFollow("user", fan.id);
    } else {
      success = await Api.instance.createFollow("user", fan.id);
    }
    if (success == true) {
      for (var i = 0; i < fans.length; i++) {
        if (fans[i].id == fan.id) {
          fans[i].isFollowing = !fans[i].isFollowing;
        }
      }
    }
    notifyListeners();
  }

  // 取关“正在关注着的用户”
  Future cancelFollowUser(User user) async {
    bool success = await Api.instance.deleteFollow("user", user.id);
    if (success == true) {
      for (var i = 0; i < followingUsers.length; i++) {
        if (followingUsers[i].id == user.id) {
          followingUsers.remove(user);
        }
      }
    }
    notifyListeners();
  }
}
