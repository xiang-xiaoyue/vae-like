import 'package:flutter/foundation.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/request/like.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/service/api.dart';

// 用户主页，判断其id与当前用户id是否相等。
class UserMainViewModel with ChangeNotifier {
  User? user; // 进入某用户的主页
  List<Post> createdPosts = [];

  UserMainViewModel(String uid) {
    getInfo(uid);
  }

  // 获取指定用户的信息
  Future getInfo(String id) async {
    user = await Api.instance.getUserInfo(id);
    // 获得指定用户创建的post列表
    if (user != null) {
      ListResp listResp = await Api.instance
          .getPostList(uid: user!.id, postType: Constants.postTypeThread);
      createdPosts.clear();
      listResp.list?.forEach((item) => createdPosts.add(Post.fromJson(item)));
    }
    notifyListeners();
  }

  // 拉黑此用户
  Future blockUser() async {
    bool success = await Api.instance.block(user!.id);
    if (success == true) {
      user!.isBlocking = true;
    }
    notifyListeners();
  }

  Future cancelBlock() async {
    bool success = await Api.instance.cancelBlock(user!.id);
    if (success == true) {
      user!.isBlocking = false;
    }
    notifyListeners();
  }

  // 点赞此用户的主页,点赞之后无法取消
  Future likeUser() async {
    // 如果已经点赞了，就什么也不做
    if (user!.isLiking == true) {
    } else {
      bool success = await Api.instance.createLike(CreateLike(
          likedId: user?.id ?? 0, likedType: Constants.likedTypeUser));
      if (success == true) {
        user!.likeCount += 1;
        user!.isLiking = true;
      }
    }
    notifyListeners();
  }

  // 关注与取关此用户
  Future toggleFollowUser() async {
    bool success;
    if (user!.isFollowing) {
      success = await Api.instance.deleteFollow("user", user!.id);
    } else {
      success = await Api.instance.createFollow("user", user!.id);
    }
    if (success == true) {
      user!.isFollowing = !user!.isFollowing;
    }
    notifyListeners();
  }
}
