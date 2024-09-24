import 'package:flutter/material.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/content.dart';
import 'package:trump/service/api.dart';

// 获取hot user发布的帖子或评论
class HotUserContentViewModel with ChangeNotifier {
  HotUserContentViewModel() {
    getContentList();
  }
  List<Content> contentList = [];
  int contentCount = 0;

  Future getContentList({String roleName = "hot"}) async {
    ListResp listResp = await Api.instance.getContentList(roleName);
    contentCount = listResp.count ?? 0;
    listResp.list?.forEach((item) {
      contentList.add(Content.fromJson(item));
    });
    notifyListeners();
  }
}
