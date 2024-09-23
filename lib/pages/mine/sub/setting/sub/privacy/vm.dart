import 'package:flutter/material.dart';
import 'package:trump/models/resp/models/user_privacy.dart';
import 'package:trump/service/api.dart';

class UserPrivacyViewModel with ChangeNotifier {
  UserPrivacyViewModel() {
    getPrivacy();
  }

  UserPrivacy? up;

  Future getPrivacy() async {
    up = await Api.instance.getUserPrivacy();
    notifyListeners();
  }

  Future<bool> updatePrivacy() async {
    bool success = await Api.instance.updateUserPrivacy(up!);
    return success;
  }
}

Map<String, String> _maps = {
  "所有人": "all-user",
  "好友": "friends",
  "仅自己": "only-self",
};
