import 'package:flutter/foundation.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/subject.dart';
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/service/api.dart';

class SearchPageViewModel with ChangeNotifier {
  List<Subject> subjects = [];
  List<Post> posts = [];
  List<User> users = [];
  int postCount = 0;
  int subjectCount = 0;
  int userCount = 0;

// 查询自己的好友,不要关键字，前端自己过滤
  // 需要锚，有锚则不清空
  getFriendListWithKeyword() async {
    ListResp listResp =
        await Api.instance.searchWithKeyword("", Constants.searchTypeFriend);
    userCount = listResp.count ?? 0;
    users.clear();
    listResp.list?.forEach((item) {
      users.add(User.fromJson(item));
    });
    notifyListeners();
  }

// 查询自己的粉丝
  // 需要锚，有锚则不清空
  getFanListWithKeyword(String keyword) async {
    ListResp listResp =
        await Api.instance.searchWithKeyword(keyword, Constants.searchTypeFans);
    userCount = listResp.count ?? 0;
    users.clear();
    listResp.list?.forEach((item) {
      users.add(User.fromJson(item));
    });
    notifyListeners();
  }

// 查询此用户正在关注的用户
  //需要锚，有锚则不清空
  getFollowingListWithKeyword(String keyword) async {
    ListResp listResp = await Api.instance
        .searchWithKeyword(keyword, Constants.searchTypeFollowing);
    userCount = listResp.count ?? 0;
    users.clear();
    listResp.list?.forEach((item) {
      users.add(User.fromJson(item));
    });
    notifyListeners();
  }
}
