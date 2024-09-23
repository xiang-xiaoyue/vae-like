import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/subject.dart';
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/service/api.dart';

class SearchSubjectViewModel with ChangeNotifier {
  SearchSubjectViewModel() {
    getLatestFollowingSubject();
  }
  String kw = ''; //搜索关键字
  bool displayResult = false;

  List<Subject> subjects = []; // 搜索的话题列表

  List<Subject> latestSubjects = []; // 最近关注的6个话题

  // todo：推荐的话题

  // 根据关键字返回搜索的话题
  Future searchSubject(String keyword) async {
    kw = keyword;
    displayResult = true;
    ListResp listResp =
        await Api.instance.searchWithKeyword(kw, Constants.searchTypeSubject);
    print("返回结果:${listResp.count}");
    listResp.list?.forEach((item) {
      subjects.add(Subject.fromJson(item));
    });
    notifyListeners();
  }

  // 取消搜索
  void cancelSearch() async {
    kw = '';
    notifyListeners();
  }

  // 获取最近关注的6个话题
  Future getLatestFollowingSubject() async {
    ListResp listResp = await Api.instance.getFollowingList("subject");
    listResp.list?.forEach((i) {
      latestSubjects.add(Subject.fromJson(i));
    });
    notifyListeners();
  }
}

// 选择@谁
class SelectAtUserViewModel with ChangeNotifier {
  String kw = ''; // 关键字
  List<User> users = []; // 搜索结果列表

  // 获取搜索出来的用户列表
  Future getUserList(String keyword) async {
    kw = keyword;
    ListResp listResp = await Api.instance.searchWithKeyword(keyword, "user");
    users.clear();
    listResp.list?.forEach((i) {
      users.add(User.fromJson(i));
    });
    notifyListeners();
  }
}
