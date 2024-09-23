import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:trump/models/request/new_comment.dart';
import 'package:trump/service/api.dart';

class CreateCommentViewModel with ChangeNotifier {
  CreateCommentViewModel({
    required this.topId,
    required this.postId,
    required this.parentId,
    required this.parentContent,
    required this.uname,
  }) {
    comment.topId = int.parse(topId);
    comment.parentId = int.parse(parentId);
    comment.postId = int.parse(postId);
  }
  final String postId;
  final String topId;
  String parentId;
  String parentContent;
  String uname;

  NewComment comment = NewComment();

  // 上传图片
  Future uploadImage(FormData fd) async {
    notifyListeners();
  }
  // 上传录音

  // 发布评论
  Future<bool> publishComment() async {
    bool success = await Api.instance.createComment(comment);
    notifyListeners();
    return success;
  }

  // notify
  void notify() {
    notifyListeners();
  }
}
