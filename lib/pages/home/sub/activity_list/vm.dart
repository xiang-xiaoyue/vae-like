import 'package:flutter/material.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/models/post.dart';
import 'package:trump/models/resp/resp.dart';
import 'package:trump/service/api.dart';

// 首页，获取“活动”列表
class ActivityListViewModel with ChangeNotifier {
  ActivityListViewModel() {
    getHomeActivityList();
  }
  List<Post> activities = [];
  int activityCount = 0;

  Future getHomeActivityList() async {
    ListResp listResp = await Api.instance.getPostList(
      postType: Constants.postTypeActivity,
    );
    activityCount = listResp.count ?? 0;
    listResp.list?.forEach((item) {
      activities.add(Post.fromJson(item));
    });
    notifyListeners();
  }
}
