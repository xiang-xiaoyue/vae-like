import 'package:flutter/material.dart';
import 'package:trump/models/resp/models/subject.dart';
import 'package:trump/models/resp/resp.dart';
import 'package:trump/service/api.dart';

class AllFollowingSubjectViewModel with ChangeNotifier {
  AllFollowingSubjectViewModel() {
    getList();
  }
  List<Subject> subjects = [];
  int count = 0;

// 查询指定用户关注的话题列表
  Future getList() async {
    ListResp listResp = await Api.instance.getFollowingList("subject");
    count = listResp.count ?? 0;
    subjects.clear();
    listResp.list?.forEach((item) {
      subjects.add(Subject.fromJson(item));
    });
    print("得到数据：${count}");
    notifyListeners();
  }
}
