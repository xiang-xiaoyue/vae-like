// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';

import 'package:trump/configs/const.dart';
import 'package:trump/models/request/like.dart';
import 'package:trump/models/resp/index.dart';
import 'package:flutter/material.dart';
import 'package:trump/models/resp/models/content.dart';
import 'package:trump/service/api.dart';

class HomeViewModel with ChangeNotifier {
  HomeViewModel() {
    //getTrendList();
    getInitialSubTypeTrendList("");
    getLatestContent();
  }

  int trendsPageIndex = TrumpCommon.pageIndex;
  int trendsPageSize = TrumpCommon.pageSize;

  List<Post> trends = [];
  Content? latestContent;

  // 获取官方动态列表,""表示获取全部trend类型.
  String subType = "";
  // 切换子类型时使用
  Future getInitialSubTypeTrendList(String t) async {
    subType = t;
    trends.clear();
    trendsPageIndex = TrumpCommon.pageIndex;
    trendsPageSize = TrumpCommon.pageSize;
    await getTrendList();
  }

  bool isLoadingTrendList = false;

  // 默认加载旧数据
  Future getTrendList({bool requireNewest = false}) async {
    if (isLoadingTrendList == true) {
      // 正在加载数据
      return;
    } else {
      isLoadingTrendList = true;
      if (requireNewest == true) {
        // 下拉刷新，请求最新数据
        await _getNewestTrendList();
      } else {
        // 上滑加载更多旧数据
        //note: 这里还有上面，如果不加await,那么滑动屏幕就会请求回来很多重复数据。
        // 不加await,那么请求在进行，还没完成的时候，下面的isLoadingTrendList=false就已经到了。
        // 然后再滑动屏幕会再请求数据。
        await _getOldTrendList();
      }
      isLoadingTrendList = false;
    }
    notifyListeners();
  }

  // 加载最新数据
  Future _getNewestTrendList() async {
    ListResp listResp = await Api.instance.getPostList(
      postType: Constants.postTypeTrends,
      postSubType: subType,
      pageSize: trendsPageSize,
      pageIndex: trendsPageIndex,
      currentPostId: trends[0].id,
    );
    listResp.list?.forEach((i) {
      trends.insert(0, Post.fromJson(i));
    });
  }

  Future _getOldTrendList() async {
    ListResp listResp = await Api.instance.getPostList(
      postType: Constants.postTypeTrends,
      postSubType: subType,
      pageSize: trendsPageSize,
      pageIndex: trendsPageIndex,
    );
    if ((listResp.list?.length ?? 0) > 0) {
      trendsPageIndex++;
    }
    listResp.list?.forEach((item) {
      trends.add(Post.fromJson(item));
    });
  }

  // 获取指定角色最新发布的内容
  Future getLatestContent({roleName = "hot"}) async {
    latestContent = await Api.instance.getLatestContent(roleName);
    notifyListeners();
  }

  // 点赞(与取消点赞)官方动态
  bool isLiking = false; // 是否正在进行点赞操作
  Future toggleLikeTrend(int trendId) async {
    bool isSuccess = false;
    int count = 0;

    Post t = trends.firstWhere((i) => i.id == trendId);
    if (t.isLiking == true) {
      isSuccess = await Api.instance.deleteLike(
          DeleteLike(likedId: trendId, likedType: Constants.likedTypePost));
      count = -1;
    } else {
      isSuccess = await Api.instance.createLike(
        CreateLike(likedId: trendId, likedType: Constants.likedTypePost),
      );
      count = 1;
    }
    if (isSuccess == true) {
      t.isLiking = !t.isLiking;
      t.likeCount += count;
      count = 0;
    }
    notifyListeners();
  }
}
