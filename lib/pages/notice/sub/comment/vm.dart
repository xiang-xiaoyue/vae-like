import 'package:flutter/material.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/notice.dart';
import 'package:trump/service/api.dart';

// 我评论的与评论我的
class CommentNoticeViewModel with ChangeNotifier {
  CommentNoticeViewModel() {
    getList();
  }

  List<Notice> myComments = [];
  List<Notice> commentsToMe = [];

  // 获取当前用户的评论类通知列表
  Future getList() async {
    ListResp listResp = await Api.instance.getMyNoticeList(['comment']);
    myComments.clear();
    commentsToMe.clear();

    listResp.list?.forEach((i) {
      Notice n = Notice.fromJson(i);
      if (n.userId == n.objectAuthorId) {
        commentsToMe.add(n);
      } else {
        myComments.add(n);
      }
    });
    notifyListeners();
  }
}
