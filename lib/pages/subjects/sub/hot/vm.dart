import 'package:flutter/material.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/service/api.dart';

class HotPostViewModel with ChangeNotifier {
  HotPostViewModel() {
    getList();
  }
  List<Post> posts = [];
  int count = 0;

  Future getList() async {
    ListResp listResp = await Api.instance.getHotPostList();
    count = listResp.count ?? 0;
    posts.clear();
    listResp.list?.forEach((item) {
      posts.add(Post.fromJson(item));
    });
    notifyListeners();
  }
}
