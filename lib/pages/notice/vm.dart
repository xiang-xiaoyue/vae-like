import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/models/notice.dart';
import 'package:trump/models/resp/resp.dart';
import 'package:trump/service/api.dart';

class NoticeIndexViewModel with ChangeNotifier {
  NoticeIndexViewModel() {
    getLikeList();
    getOfficialList();
    getCommentList();
    getAtList();
  }
  int likeUnreadCount = 0;
  int atUnreadCount = 0;
  int officialUnreadCount = 0;
  int commentUnreadCount = 0;

  // 将消息状态改为已读
  Future readNotice(String type, int id) async {
    bool success;
    success = await Api.instance.readNotice(id: 0, type: type);
    if (success == true) {
      await getLikeList();
      await getOfficialList();
      await getCommentList();
      await getAtList();
    }
    notifyListeners();
  }

  int isUnread(String status, int count) {
    if (status == "unread") {
      count += 1;
      return count;
    }
    return 0;
  }

  List<Notice> likeMeList = []; // 赞我的
  List<Notice> myLikeList = []; // 我赞的

  List<Notice> officialList = []; // 官方通知

  // 查询user_id点赞别人的发布内容的记录
  Future getLikeList() async {
    ListResp listResp = await Api.instance.getMyNoticeList(['like']);
    myLikeList.clear();
    likeMeList.clear();
    listResp.list?.forEach((i) {
      Notice n = Notice.fromJson(i);
      likeUnreadCount = isUnread(n.status, likeUnreadCount);
      if (n.userId == n.objectAuthorId) {
        likeMeList.add(n);
      } else {
        myLikeList.add(n);
      }
    });
    notifyListeners();
  }

  // 查询官方通知
  Future getOfficialList() async {
    ListResp listResp = await Api.instance.getMyNoticeList(
      [Constants.noticeTypeOfficial],
    );
    officialList.clear();
    listResp.list?.forEach((i) {
      Notice n = Notice.fromJson(i);
      officialUnreadCount = isUnread(n.status, officialUnreadCount);
      officialList.add(n);
    });
    notifyListeners();
  }

// 我评论的与评论我的
  List<Notice> myComments = [];
  List<Notice> commentsToMe = [];
  // 获取当前用户的评论类通知列表
  Future getCommentList() async {
    ListResp listResp = await Api.instance.getMyNoticeList(['comment']);
    myComments.clear();
    commentsToMe.clear();

    listResp.list?.forEach((i) {
      Notice n = Notice.fromJson(i);
      commentUnreadCount = isUnread(n.status, commentUnreadCount);
      if (n.userId == n.objectAuthorId) {
        commentsToMe.add(n);
      } else {
        myComments.add(n);
      }
    });
    notifyListeners();
  }

  // @我的
  List<Notice> postAtMeList = [];
  List<Notice> commentAtMeList = [];
  Future getAtList() async {
    ListResp listResp = await Api.instance.getMyNoticeList(["at"]);
    postAtMeList.clear();
    commentAtMeList.clear();
    listResp.list?.forEach((i) {
      Notice n = Notice.fromJson(i);
      atUnreadCount = isUnread(n.status, atUnreadCount);
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
