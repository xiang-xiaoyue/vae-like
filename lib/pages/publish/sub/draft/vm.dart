import 'package:flutter/material.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/service/api.dart';

class DraftViewModel with ChangeNotifier {
  DraftViewModel() {
    getDraftPostList();
  }
  bool isEditing = false;
  void toggleEditing() {
    isEditing = !isEditing;
    notifyListeners();
  }

  int pageIndex = TrumpCommon.pageIndex;
  int pageSize = TrumpCommon.pageSize;
  List<Post> posts = [];
  bool isLoading = false;

  // 删除草稿
  Future removePost(Post p) async {
    bool success = false;
    int index = posts.indexOf(p);
    posts.remove(p);
    success = await Api.instance.deletePost(p.id);
    if (success == false) {
      posts.insert(index, p);
    }
    notifyListeners();
  }

  Future getDraftPostList() async {
    if (isLoading == false) {
      isLoading = true;
      ListResp listResp = await Api.instance.getPostList(
        postType: Constants.postTypeThread,
        pageIndex: pageIndex,
        pageSize: pageSize,
        status: "draft",
      );
      if ((listResp.list?.length ?? 0) > 0) {}
      listResp.list?.forEach((i) {
        posts.add(Post.fromJson(i));
      });
      pageIndex += 1;
      isLoading = false;
    }

    notifyListeners();
  }
}
