import 'package:flutter/material.dart';
import 'package:trump/service/api.dart';

class FeedbackViewModel with ChangeNotifier {
  static const String adviceTypeBug = "bug";
  static const String adviceTypeBetter = "better";
  static const String adviceTypeElse = "else";

  String adviceContent = '';
  String adviceType = adviceTypeBug;

  // 提交advice
  Future<bool> createAdvice() async {
    print("内容：$adviceContent");
    bool success = await Api.instance.createAdvice(adviceContent, adviceType);
    notifyListeners();
    return success;
  }

  // 设置adviceType
  Future setType(String t) async {
    adviceType = t;
    notifyListeners();
  }
}
