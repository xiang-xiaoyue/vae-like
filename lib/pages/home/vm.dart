import 'package:trump/configs/const.dart';
import 'package:trump/models/request/like.dart';
import 'package:trump/models/resp/index.dart';
import 'package:flutter/material.dart';
import 'package:trump/models/resp/models/content.dart';
import 'package:trump/service/api.dart';

// 首页，官方动态列表
class TrendsListViewModel with ChangeNotifier {
  List<Post> posts = [];
  int postCount = 0;
}

class HomeViewModel with ChangeNotifier {
  HomeViewModel() {
    getHomeTrendList();
    getLatestContent();
  }

  List<Post> trends = [];
  int trendCount = 0;
  Content? latestContent;

  // 获取官方动态列表
  //todo: 按分类返回
  Future getHomeTrendList({subType = ""}) async {
    ListResp listResp = await Api.instance.getPostList(
      postType: Constants.postTypeTrends,
      postSubType: subType,
    );
    trendCount = listResp.count ?? 0;
    listResp.list?.forEach((item) {
      trends.add(Post.fromJson(item));
    });
    notifyListeners();
  }

  // 获取指定角色最新发布的内容
  Future getLatestContent({roleName = "hot"}) async {
    latestContent = await Api.instance.getLatestContent(roleName);
    notifyListeners();
  }

  // 切换点赞官方动态
  Future toggleLikeTrend(int trendId) async {
    bool isSuccess;
    // ignore: avoid_function_literals_in_foreach_calls
    trends.forEach((item) async {
      if (item.id == trendId) {
        if (item.isLiking == true) {
          // 取消点赞
          isSuccess = await Api.instance.deleteLike(
              DeleteLike(likedId: trendId, likedType: Constants.likedTypePost));
        } else {
          // 点赞
          isSuccess = await Api.instance.createLike(
            CreateLike(likedId: trendId, likedType: Constants.likedTypePost),
          );
        }

        if (isSuccess == true) {
          item.isLiking = !item.isLiking;
        }
      }
    });
    notifyListeners();
  }
}
