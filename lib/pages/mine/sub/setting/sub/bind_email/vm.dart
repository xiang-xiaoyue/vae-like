import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trump/service/api.dart';

class BindEmailViewModel with ChangeNotifier {
  String email = '';
  String code = '';
  int seconds = 0;

  // 获取验证码，验证码发到邮箱
  Future getVeriCode() async {
    bool success =
        await Api.instance.getVeriCode(accountStr: email, type: "email");
    if (success == true) {
      seconds = 60;
      print("点击了，准备定时任务");
      Timer.periodic(Duration(milliseconds: 1000), (t) {
        if (seconds == 0) {
          return;
        }
        seconds -= 1;
        notifyListeners();
      });
      notifyListeners();
    }
  }

  // 发送验证码与账号，进行验证
  Future validate() async {
    bool success = await Api.instance
        .validateVeriCode(accountStr: email, type: "email", code: code);
    if (success == true) {
      notifyListeners();
    }
    return success;
  }
}
