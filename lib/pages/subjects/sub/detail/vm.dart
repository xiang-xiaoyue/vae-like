import 'package:flutter/material.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/subject.dart';
import 'package:trump/service/api.dart';

class SubjectDetailViewModel with ChangeNotifier {
  SubjectDetailViewModel.init(String subjectId) {
    getSubjectDetail(subjectId).then((_) {
      getPostList();
    });
  }
  Subject? subject;
  List<Post> threads = []; //帖子列表，以时间倒序

  List<Post> gloryThreads = []; // 加精的帖子

  int curIdx = 0;
  void setCurIdx(int i) {
    curIdx = i;
    notifyListeners();
  }

  // 获取话题下全帖子
  Future getPostList() async {
    ListResp listResp = await Api.instance.getPostList(
        postType: Constants.postTypeThread, subjectID: subject!.id);
    threads.clear();
    gloryThreads.clear();
    listResp.list?.forEach((item) {
      Post p = Post.fromJson(item);
      threads.add(p);
      if (p.isGlory == true) {
        gloryThreads.add(p);
      }
    });
    notifyListeners();
  }

  // 查询话题详情
  Future getSubjectDetail(String id) async {
    Resp resp = await Api.instance.getSubjectDetail(id: id);
    subject = Subject.fromJson(resp.data);
    notifyListeners();
  }

  // 关注/取关话题
  Future toggleFollowSubject() async {
    bool success;
    if ((subject?.isFollowing ?? false) == true) {
      //取关
      success = await Api.instance.deleteFollow("subject", subject?.id ?? 0);
    } else {
      success = await Api.instance.createFollow("subject", subject?.id ?? 0);
    }
    if (success == true) {
      subject!.isFollowing = !subject!.isFollowing;
    }
    notifyListeners();
  }
}
