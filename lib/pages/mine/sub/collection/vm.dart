import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/service/api.dart';

// if (user != null) {
//   ListResp listResp = await Api.instance
//       .getFollowingList("subject", (user?.id ?? 0).toString());
//   followingSubjectCount = listResp.count ?? 0;
//   listResp.list?.forEach((item) {
//     followingSubjects.add(Subject.fromJson(item));
//   });
//

class MineCollectionViewModel with ChangeNotifier {
  MineCollectionViewModel() {
    getCollectingPostListWithType(Constants.CollectingTypeTrip);
    getCollectingPostListWithType(Constants.CollectingTypeTrends);
    getCollectingPostListWithType(Constants.CollectingTypeActivity);
    getCollectingPostListWithType(Constants.CollectingTypeInSubject);
  }
  // 收藏的新闻（实际只要是“trends”都行）
  List<Post> trends = [];
  // 收藏的行程
  List<Post> trips = [];

  // 收藏的活动
  List<Post> activities = [];
  // 关注的话题下的收藏的post（帖子）
  List<Post> threads = [];

  Future getCollectingPostListWithType(String t) async {
    ListResp listResp = await Api.instance.getCollectingPostList(type: t);
    switch (t) {
      case Constants.CollectingTypeTrends:
        trends.clear();
        listResp.list?.forEach((item) {
          trends.add(Post.fromJson(item));
        });
        break;
      case Constants.CollectingTypeActivity:
        activities.clear();
        listResp.list?.forEach((item) {
          activities.add(Post.fromJson(item));
        });
        break;
      case Constants.CollectingTypeTrip:
        trips.clear();
        listResp.list?.forEach((item) {
          trips.add(Post.fromJson(item));
        });
        break;
      case Constants.CollectingTypeInSubject:
        trends.clear();
        listResp.list?.forEach((item) {
          trends.add(Post.fromJson(item));
        });
        break;
    }
    notifyListeners();
  }
}
// Future dealList(List<int> followingSubjectIdList) async {
//   print("dealing...");
//   for (var p in posts) {
//     switch (p.type) {
//       case Constants.postTypeTrends:
//         trends.add(p);
//         trendCount += 1;
//         break;
//       case Constants.postTypeActivity:
//         activities.add(p);
//         activityCount += 1;
//         break;
//       case Constants.postTypeTrip:
//         trips.add(p);
//         tripCount += 1;
//         break;
//       case Constants.postTypeThread:
//         if (followingSubjectIdList.indexOf(p.subject.id) >= 0) {
//           // 当前p是此用户关注着的话题下的
//           threads.add(p);
//           threadCount += 1;
//         }
//         break;
//     }
//   }
//   notifyListeners();
// }
//
// Future getCollectingPostListWithoutType() async {
//   ListResp listResp = await Api.instance.getCollectingPostList();
//   totalCount = listResp.count ?? 0;
//   listResp.list?.forEach((item) {
//     posts.add(Post.fromJson(item));
//   });
//   notifyListeners();
// }
// // 总数量
// int totalCount = 0;
// List<Post> posts = [];
