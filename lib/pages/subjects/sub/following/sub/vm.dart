import 'package:flutter/material.dart';
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
  Future getFollowingPostList() async {
    ListResp listResp = await Api.instance.getPostList(isFollowing: true);

    postCount = listResp.count ?? 0;
    posts.clear();
    listResp.list?.forEach((item) {
      posts.add(Post.fromJson(item));
    });
    notifyListeners();
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
