import 'package:flutter/material.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/comment.dart';
import 'package:trump/service/api.dart';

class CommentDetailViewModel with ChangeNotifier {
  CommentDetailViewModel(String id) {
    getCommentDetail(id);
    getReplyList(id);
  }
  Comment? comment;
  List<Comment> replyList = [];
  int replyCount = 0;

  // 获取评论详情
  Future getCommentDetail(String id) async {
    Resp resp = await Api.instance.getCommentDetail(id);
    comment = Comment.fromJson(resp.data);
    notifyListeners();
  }

  // 获取评论下相关回复列表
  Future getReplyList(String id) async {
    ListResp listResp = await Api.instance.getCommentListByParentID(id);
    replyCount = listResp.count ?? 0;
    listResp.list?.forEach((item) {
      replyList.add(Comment.fromJson(item));
    });
    notifyListeners();
  }
}
