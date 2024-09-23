import 'package:flutter/material.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/models/post.dart';
import 'package:trump/models/resp/resp.dart';
import 'package:trump/service/api.dart';

// 获取用户创建的视频列表
//todo: 首页没有用户创建的视频列表，只有官方的视频列表
class VideoListViewModel with ChangeNotifier {
  VideoListViewModel() {
    getTrendVideoList();
  }

  List<Post> trendVideos = [];
  int trendVideoCount = 0;

  Future getTrendVideoList() async {
    ListResp listResp = await Api.instance.getPostList(
      postType: Constants.postTypeTrends,
      postSubType: Constants.postSubTypeVideo,
    );
    trendVideoCount = listResp.count ?? 0;
    listResp.list?.forEach((item) {
      trendVideos.add(Post.fromJson(item));
    });
    notifyListeners();
  }
}
