import 'package:flutter/material.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/comment.dart';
import 'package:trump/service/api.dart';

class GoodsDetailViewModel with ChangeNotifier {
  GoodsDetailViewModel(String id) {
    getGoods(id);
    getCommentList(id);
  }
  Post? goods;
  List<Comment> comments = [];

  Future getGoods(String id) async {
    goods = await Api.instance.getPostByID(id: id);
    notifyListeners();
  }

  Future getCommentList(String id) async {
    ListResp listResp = await Api.instance.getCommentListByPostID(id);
    comments.clear();
    listResp.list?.forEach((i) {
      comments.add(Comment.fromJson(i));
    });
    notifyListeners();
  }
}
