import 'package:flutter/material.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/notice.dart';
import 'package:trump/service/api.dart';

class LikeNoticeViewModel with ChangeNotifier {
  LikeNoticeViewModel(int uid) {
    getList(uid);
  }
  List<Notice> likeMeList = [];
  List<Notice> myLikeList = [];

  // 查询user_id点赞别人的发布内容的记录
  Future getList(int uid) async {
    ListResp listResp = await Api.instance.getMyNoticeList(['like']);
    myLikeList.clear();
    likeMeList.clear();
    listResp.list?.forEach((i) {
      Notice n = Notice.fromJson(i);
      if (n.userId == n.objectAuthorId) {
        likeMeList.add(n);
      } else {
        myLikeList.add(n);
      }
    });
    notifyListeners();
  }
}
