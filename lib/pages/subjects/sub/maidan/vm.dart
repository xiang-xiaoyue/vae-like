import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/configs/routes/notice.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/subject.dart';
import 'package:trump/service/api.dart';

// 话题广场页面
class MaidanPageViewModel with ChangeNotifier {
  MaidanPageViewModel() {
    postPageIndex = 1;
    postPageSize = 3;
    getRecommendedSubjectList();
    getSubjectList();
    getPostList();
  }
  // 圈子首页展示话题列表
  List<Subject> subjects = [];
  int subjectCount = 0;

  // 官方推荐话题列表
  List<Subject> recommendedSubjects = [];

  List<Post> posts = [];
  int postPageIndex = 1;
  int postPageSize = 3;

  bool isLoadingPostList = false;
  bool noMoreOldPost = false; // 没有更多旧数据
  void setIsLoadingPostList(bool v) {
    isLoadingPostList = v;
    notifyListeners();
  }

  //查询全部话题,当前限制100个,todo:在主页面显示，应当传入限制数量
  Future getSubjectList() async {
    ListResp listResp = await Api.instance.getSubjectList(limit: 100);
    subjectCount = listResp.count ?? 0;
    subjects.clear();
    listResp.list?.forEach((item) {
      subjects.add(Subject.fromJson(item));
    });
    notifyListeners();
  }

  // 获取官方推荐话题
  Future getRecommendedSubjectList() async {
    ListResp listResp = await Api.instance.getSubjectList(isRecommended: true);
    recommendedSubjects.clear();
    listResp.list?.forEach((i) {
      recommendedSubjects.add(Subject.fromJson(i));
    });
    notifyListeners();
  }

  // 获取全部帖子列表,默认用于加载旧内容
  Future getPostList({bool requireNewest = false}) async {
    if (requireNewest == false) {
      _loadOldPostList();
    } else {
      _loadNewestPostList();
    }
    notifyListeners();
  }

  Future _loadNewestPostList() async {
    ListResp listResp = await Api.instance.getPostList(
      postType: Constants.postTypeThread,
      currentPostId: posts[0].id,
    );
    if ((listResp.list?.length ?? 0) > 0) {
      listResp.list?.forEach((i) {
        posts.insert(0, Post.fromJson(i));
      });
    }
  }

  Future _loadOldPostList() async {
    ListResp listResp = await Api.instance.getPostList(
      postType: Constants.postTypeThread,
      pageIndex: postPageIndex,
      pageSize: postPageSize,
    );
    if (listResp.list == null) {
      // 旧数据已全部加载完
      noMoreOldPost = true;
    }
    if ((listResp.list?.length ?? 0) > 0) {
      listResp.list?.forEach((item) {
        posts.add(Post.fromJson(item));
      });
      postPageIndex++;
    }
  }
}
