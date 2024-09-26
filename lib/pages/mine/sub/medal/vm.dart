import 'package:flutter/material.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/medal.dart';
import 'package:trump/service/api.dart';

class MedalViewModel with ChangeNotifier {
  MedalViewModel() {
    getAllMedalList();
  }
  List<Medal> medals = [];
  bool isRequesting = false; // 当前正在发送请求

  // 查询全部的勋章
  Future getAllMedalList() async {
    ListResp listResp = await Api.instance.getAllMedal();
    medals.clear();
    listResp.list?.forEach((i) {
      medals.add(Medal.fromJson(i));
    });
    notifyListeners();
  }

  // 兑换勋章（获得勋章）
  Future gainMedal(int id) async {
    if (isRequesting == true) {
      return;
    }
    isRequesting = true;
    bool success = await Api.instance.gainMedal(medalId: id);
    if (success == true) {
      medals.firstWhere((i) => i.id == id).isHolding = true;
    }
    isRequesting = false;
    notifyListeners();
  }

  // 设置为挂件（佩戴勋章）,也支持取消佩戴
  Future wearMedal(Medal m) async {
    if (isRequesting == true) {
      return;
    }
    isRequesting = true;
    bool success = false;
    if (m.isWearing == true) {
      // 取消佩戴
      success = await Api.instance.updateUserMedal(id: m.id, isWearing: false);
    } else {
      // 佩戴
      success = await Api.instance.updateUserMedal(id: m.id, isWearing: true);
      for (var i in medals) {
        i.isWearing = false;
      }
    }
    if (success == true) {
      m.isWearing = !m.isWearing;
    }
    isRequesting = false;
    notifyListeners();
  }
}
