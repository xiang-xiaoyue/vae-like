import 'package:flutter/material.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/notice.dart';
import 'package:trump/service/api.dart';

class OfficialViewModel with ChangeNotifier {
  OfficialViewModel() {
    getList();
  }
  //官方消息通知列表
  List<Notice> ns = [];

  Future getList() async {
    ListResp listResp =
        await Api.instance.getMyNoticeList([Constants.noticeTypeOfficial]);
    ns.clear();
    listResp.list?.forEach((i) {
      ns.add(Notice.fromJson(i));
    });
    notifyListeners();
  }
}
