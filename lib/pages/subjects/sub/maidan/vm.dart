import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/subject.dart';
import 'package:trump/service/api.dart';

// 话题广场页面
class MaidanPageViewModel with ChangeNotifier {
  MaidanPageViewModel() {
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
  int postCount = 0;

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

  // 获取全部帖子列表
  Future getPostList() async {
    ListResp listResp =
        await Api.instance.getPostList(postType: Constants.postTypeThread);
    posts.clear();
    listResp.list?.forEach((item) {
      posts.add(Post.fromJson(item));
    });
    notifyListeners();
  }
}
