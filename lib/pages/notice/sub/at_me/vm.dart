import 'package:flutter/material.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/notice.dart';

import 'package:trump/service/api.dart';

class AtMeViewModel with ChangeNotifier {
  AtMeViewModel() {
    getList();
  }
  List<Notice> postAtMeList = [];
  List<Notice> commentAtMeList = [];

  Future getList() async {
    ListResp listResp = await Api.instance.getMyNoticeList(["at"]);
    postAtMeList.clear();
    commentAtMeList.clear();
    listResp.list?.forEach((i) {
      Notice n = Notice.fromJson(i);
      if (n.objectType == "comment") {
        commentAtMeList.add(n);
      }
      if (n.objectType == "post") {
        postAtMeList.add(n);
      }
    });
    notifyListeners();
  }
}
