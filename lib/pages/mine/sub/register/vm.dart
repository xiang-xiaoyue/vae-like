import 'package:flutter/material.dart';
import 'package:trump/models/request/user.dart';
import 'package:trump/models/resp/resp.dart';
import 'package:trump/service/api.dart';
import 'package:trump/service/save.dart';

class RegisterViewModel with ChangeNotifier {
  Register registerData = Register();
  String tipText = '';
  bool isLoading = false;

  Future<bool> register() async {
    isLoading = true;
    bool success;
    Resp resp = await Api.instance.register(registerData);
    if (resp.code == 0) {
      tipText = "";
      await SaveService.writeString(resp.data);
      success = true;
    } else {
      tipText = resp.msg ?? '注册失败';
      success = false;
    }
    isLoading = false;
    notifyListeners();
    return success;
  }

  displayTipText() {
    if (registerData.password != registerData.repeatPassword) {
      tipText = "两次输入密码不一致";
    } else if (registerData.email.isEmpty ||
        registerData.password.isEmpty ||
        registerData.repeatPassword.isEmpty ||
        registerData.name.isEmpty) {
      tipText = "所有字段都是必填项，不能为空";
    } else {
      tipText = '';
    }
    notifyListeners();
  }
}
