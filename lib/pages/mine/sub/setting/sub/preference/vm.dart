import 'package:flutter/material.dart';
import 'package:trump/models/resp/models/user_preference.dart';
import 'package:trump/service/api.dart';

class UserPreferenceViewModel with ChangeNotifier {
  UserPreferenceViewModel() {
    getPreference();
  }
  UserPreference? up;

  Future getPreference() async {
    up = await Api.instance.getUserPreference();
    notifyListeners();
  }

  Future<bool> updatePreference() async {
    bool success = await Api.instance.updateUserPreference(up!);
    notifyListeners();
    return success;
  }
}
