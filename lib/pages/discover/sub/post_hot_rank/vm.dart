import 'package:flutter/material.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/service/api.dart';

class PostHotRankViewModel with ChangeNotifier {
  PostHotRankViewModel() {
    getList();
  }
  List<Post> posts = [];

  Future getList() async {
    ListResp listResp =
        await Api.instance.getRankList(entityType: "thread", type: "hot");
    posts.clear();
    listResp.list?.forEach((i) {
      posts.add(Post.fromJson(i));
    });
    notifyListeners();
  }
}
