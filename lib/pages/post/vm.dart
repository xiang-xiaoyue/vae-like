import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/request/like.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/comment.dart';
import 'package:trump/service/api.dart';

class PostDetailViewModel with ChangeNotifier {
  final String id;
  PostDetailViewModel({required this.id}) {
    _getPostDetail(id);
    _getCommentListByPostID(id);
  }

  Post? post;
  List<Comment> comments = [];
  int commentCount = 0;

  // 获取post详情
  Future _getPostDetail(String id) async {
    post = await Api.instance.getPostByID(id: id);
    notifyListeners();
  }

  // 投票
  Future vote(int voteOptionId) async {
    bool success = await Api.instance.vote(post!.id, voteOptionId);
    if (success) {
      post!.voteResult?.forEach((option) {
        if (option.voteOptionId == voteOptionId) {
          option.isVoted = true;
          option.voteCount += 1;
        }
      });
    }
    notifyListeners();
  }

  // 获取此post下的评论列表
  Future _getCommentListByPostID(String id) async {
    ListResp listResp = await Api.instance.getCommentListByPostID(id);
    commentCount = listResp.count ?? 0;
    listResp.list?.forEach((item) {
      comments.add(Comment.fromJson(item));
    });
    notifyListeners();
  }

  // 收藏post
  Future toggleCollection() async {
    bool isSuccess = false;
    if (post!.isCollecting == true) {
      // 已经收藏了，取消收藏
      isSuccess = await Api.instance.cancelCollectPost(post!.id);
    } else {
      isSuccess = await Api.instance.collectPost(post!.id);
    }
    if (isSuccess == true) {
      post!.isCollecting = !post!.isCollecting;
      notifyListeners();
    }
  }

  // 点赞post
  Future toggleLikePost() async {
    bool isSuccess = false;
    int addNumber = 0;
    if (post!.isLiking == true) {
      // 已经点赞了，取消点赞
      isSuccess = await Api.instance.deleteLike(
        DeleteLike(
          likedId: post!.id,
          likedType: Constants.likedTypePost,
        ),
      );
      addNumber = -1;
    } else {
      isSuccess = await Api.instance.createLike(
        CreateLike(
          likedId: post!.id,
          likedType: Constants.likedTypePost,
        ),
      );
      addNumber = 1;
    }

    if (isSuccess == true) {
      post!.isLiking = !post!.isLiking;
      post!.likeCount += addNumber;
    }
    notifyListeners();
  }

  // 点赞post下的具体评论
  Future toggleLikeComment(Comment comment) async {
    bool success = false;
    int addNumber = 0;
    if (comment.isLiking == true) {
      // 取消点赞
      success = await Api.instance.deleteLike(DeleteLike(
          likedId: comment.id, likedType: Constants.likedTypeComment));
      addNumber = -1;
    } else {
      // 点赞
      success = await Api.instance.createLike(CreateLike(
          likedId: comment.id, likedType: Constants.likedTypeComment));
      addNumber = 1;
    }
    if (success == true) {
      comment.isLiking = !comment.isLiking;
      comment.likeCount += addNumber;
    }
    notifyListeners();
  }
}
