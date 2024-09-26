import 'package:flutter/material.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/service/api.dart';

class HotPostViewModel with ChangeNotifier {
  HotPostViewModel() {
    getList();
  }
  List<Post> posts = [];
  int count = 0;

  int pageIndex = TrumpCommon.pageIndex;
  int pageSize = TrumpCommon.pageSize;
  bool isLoading = false;

  Future getList({bool requireNewest = false}) async {
    if (isLoading == true) {
      return;
    } else {
      isLoading = true;
      if (requireNewest == true) {
        await _loadNewest();
      } else {
        await _loadOldList();
      }
      isLoading = false;
    }
    notifyListeners();
  }

  // 下拉刷新加载新数据
  Future _loadNewest() async {
    ListResp listResp =
        await Api.instance.getHotPostList(currentPostId: posts[0].id);
    count = listResp.count ?? count;
    listResp.list?.forEach((i) {
      posts.insert(0, Post.fromJson(i));
    });
    notifyListeners();
  }

  // 加载旧数据
  bool hasMore = true; // 是否有更多旧的帖子可以加载
  Future _loadOldList() async {
    if (hasMore == false) {
      return;
    }
    ListResp listResp = await Api.instance
        .getHotPostList(pageIndex: pageIndex, pageSize: pageSize);
    count = listResp.count ?? count;
    if ((listResp.list?.length ?? 0) == 0) {
      hasMore = false;
    } else {
      pageIndex++;
      hasMore = true;
    }
    listResp.list?.forEach((item) {
      posts.add(Post.fromJson(item));
    });
  }
}
