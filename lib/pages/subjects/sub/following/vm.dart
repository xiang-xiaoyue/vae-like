import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/subject.dart';
import 'package:trump/service/api.dart';

class FollowingPageViewModel with ChangeNotifier {
  FollowingPageViewModel() {
    getFollowingPostList();
    getFollowingSubjectList();
  }
  List<Post> posts = [];
  int postCount = 0;

  List<Subject> subjects = [];
  int subjectCount = 0;

  // 查询指定用户关注的话题下的帖子（一般只查自己的）
  int pageIndex = TrumpCommon.pageIndex;
  int pageSize = TrumpCommon.pageSize;
  bool isLoading = false;
  bool hasMorePost = true; // 是否有更多旧post可加载
  Future getFollowingPostList({bool requireNewest = false}) async {
    if (isLoading == true) {
      notifyListeners();
      return;
    }
    isLoading = true;
    if (requireNewest == true) {
      await _loadNewestPost();
    } else {
      await _loadMorePost();
    }
    isLoading = false;
    notifyListeners();
  }

  // 加载更多旧帖子
  Future _loadMorePost() async {
    ListResp listResp = await Api.instance.getPostList(
      isFollowing: true,
      pageIndex: pageIndex,
      pageSize: pageSize,
      postType: Constants.postTypeThread,
    );
    postCount = listResp.count ?? postCount;
    if (listResp.list != null) {
      pageIndex++;
      hasMorePost = true;
    } else {
      hasMorePost = false;
      return;
    }
    listResp.list?.forEach((item) {
      posts.add(Post.fromJson(item));
    });
  }

  // 加载最新的帖子
  Future _loadNewestPost() async {
    ListResp listResp = await Api.instance.getPostList(
      currentPostId: posts[0].id,
      postType: Constants.postTypeThread,
      isFollowing: true,
    );
    postCount = listResp.count ?? postCount;
    listResp.list?.forEach((i) {
      posts.insert(0, Post.fromJson(i));
    });
  }

  Future getFollowingSubjectList() async {
    ListResp listResp = await Api.instance.getFollowingList("subject");
    subjectCount = listResp.count ?? 0;
    subjects.clear();
    listResp.list?.forEach((item) {
      subjects.add(Subject.fromJson(item));
    });
    notifyListeners();
  }
}
