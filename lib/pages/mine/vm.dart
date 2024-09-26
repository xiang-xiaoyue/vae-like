// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/subject.dart';
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/service/api.dart';
import 'package:trump/service/save.dart';

// 当前用户的视图模型
class CurrentUserViewModel with ChangeNotifier {
  User? user;

  bool isLoggedIn = false;

  int totalImprovedData = 5;

  String token = '';
  List<Subject> followingSubjects = [];
  int followingSubjectCount = 0;

  // 登录
  String loginEmail = '';
  String loginPassword = '';
  Future<bool> login() async {
    token = await Api.instance.login(
      email: loginEmail,
      password: loginPassword,
    );
    await SaveService.writeString(token);
    setLoginStatus(true);
    notifyListeners();
    await getProfile();
    loginEmail = '';
    loginPassword = '';
    return isLoggedIn;
  }

  // 因为不想用StatefulWidget,所以定义这个方法当作setState用
  void notify() {
    notifyListeners();
  }

  // 初始化时加载本地token
  CurrentUserViewModel() {
    _loadToken();
  }
  CurrentUserViewModel.initProfile() {
    _loadToken().then((_) {
      getProfile().then((success) {
        if (success == true) {
          setLoginStatus(true);
          // 在线时长加一分钟
          Timer.periodic(Duration(seconds: 60), (timer) {
            Api.instance.addOnlineMinutes();
          });
          dailyLogin();
        } else {
          setLoginStatus(false);
          SaveService.writeString("");
        }
      });
    });
  }

  // 每日登录（task）
  Future<bool> dailyLogin() async {
    bool success = await Api.instance.dailyLogin();
    notifyListeners();
    return success;
  }

  // 登出
  Future<bool> logout() async {
    bool success = await Api.instance.logout();
    if (success) {
      await SaveService.writeString("");
      isLoggedIn = false;
      user = null;
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  // 设置当前用户登录状态
  setLoginStatus(bool isLogged) {
    isLoggedIn = isLogged;
    notifyListeners();
  }

  // 完善“修改资料”页面的资料
  Future updateImproveData() async {}

  // 从本地加载token
  Future _loadToken() async {
    token = await SaveService.readString();
    notifyListeners();
  }

  // 利用token获取自己的信息
  Future<bool> getProfile() async {
    user = await Api.instance.getProfile();
    notifyListeners();
    return user != null;
  }

  // 设置生日
  Future setBirthday(int v) async {
    user!.birthday = v;
    notifyListeners();
  }

  // 更新信息
  Future updateCurrentUser() async {
    await Api.instance.updateUserInfo(user!);
    notifyListeners();
  }

// 更新密码,密码是比较特殊的用户信息，单独做个方法
  Future<String> updatePwd() async {
    String str = await Api.instance.updateUserInfo(user!);
    notifyListeners();
    return str;
  }

  // 当前编辑的帖子信息（用于从草稿箱跳转到编辑页面）
  // 一是用起来方便，二是减少网络请求
  Post? currentEdittingThread;
  Future saveCurrentEdittingThread(Post? p) async {
    print("清空了帖子信息");
    currentEdittingThread = p;
    notifyListeners();
  }
}
