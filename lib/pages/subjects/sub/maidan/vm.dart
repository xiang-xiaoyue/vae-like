import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/configs/routes/notice.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/subject.dart';
import 'package:trump/service/api.dart';

// 话题广场页面
class MaidanPageViewModel with ChangeNotifier {
  MaidanPageViewModel() {
    postPageIndex = TrumpCommon.pageIndex;
    postPageSize = TrumpCommon.pageSize;
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
  int postPageIndex = TrumpCommon.pageIndex;
  int postPageSize = TrumpCommon.pageSize;
  int currentPostId = 0; //当前被点击查看详情的post的id

  bool isLoadingPostList = false;
  bool hasMorePost = true; // 有没有更多旧帖子可加载

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
    if (isLoadingPostList == true) {
      notifyListeners();
      return;
    }
    isLoadingPostList = true;
    if (requireNewest == false) {
      await _loadOldPostList();
    } else {
      await _loadNewestPostList();
    }
    isLoadingPostList = false;
    notifyListeners();
  }

  // 从详情页面退回时，重新加载指定的post,并替换
  Future replacePostById(int id) async {
    Post p = await Api.instance.getPostByID(id: id.toString());
    int idx = posts.indexWhere((i) => i.id == p.id);
    posts.replaceRange(idx, idx + 1, [p]);
    notifyListeners();
  }

  Future _loadNewestPostList() async {
    ListResp listResp = await Api.instance.getPostList(
      postType: Constants.postTypeThread,
      currentPostId: posts[0].id,
    );
    listResp.list?.forEach((i) {
      posts.insert(0, Post.fromJson(i));
    });
  }

  Future _loadOldPostList() async {
    if (hasMorePost == false) {
      notifyListeners();
      return;
    }
    ListResp listResp = await Api.instance.getPostList(
      postType: Constants.postTypeThread,
      pageIndex: postPageIndex,
      pageSize: postPageSize,
    );
    if (listResp.list == null) {
      // 旧数据已全部加载完
      hasMorePost = false;
    }
    if ((listResp.list?.length ?? 0) > 0) {
      hasMorePost = true;
      listResp.list?.forEach((item) {
        posts.add(Post.fromJson(item));
      });
      postPageIndex++;
    }
  }
}
