import 'package:flutter/material.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/subject.dart';
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/service/api.dart';

class MainSearchViewModel with ChangeNotifier {
  MainSearchViewModel() {
    getLatestSubjectList();
  }
  // 当前页面索引
  int pageIndex = 0;
  void changeTab(int index) {
    pageIndex = index;
    if (index == 0) {
      // 获取帖子
      getPostListWithKeyword(curKeyword);
    } else if (index == 1) {
      // 获取话题
      getSubjectListWithKeyword(curKeyword);
    } else if (index == 2) {
      // 获取用户
      getUserListWithKeyword(curKeyword);
    }
    notifyListeners();
  }

  // 是否显示搜索历史记录，清空就不显示了
  bool showSearchHistory = true;
  //当前搜索类型
  String searchType = Constants.searchTypeThread;
  //为true表示是默认的主搜索页面，为false表示搜索结果的展示页面
  bool isDefaultSearchPage = true;
  int index = 0;
  void showResult() {
    isDefaultSearchPage = false;
    index = 1;
    notifyListeners();
  }

  //todo: 保存到本地
  List<String> historyList = ['华为', '杭州']; // 历史记录

  List<Subject> latestSubjectList = []; // 最新话题，最多50个

  List<Post> postList = [];
  int postCount = 0;

  //当前的keyword
  String curKeyword = '';
  // 改变当前keyword
  void changeKeyword(String k) {
    curKeyword = k;
    isDefaultSearchPage = false;
    notifyListeners();
    //_requestData();
  }

  // 获取最新50条话题
  Future getLatestSubjectList() async {
    ListResp listResp = await Api.instance.getSubjectList(limit: 50);
    listResp.list?.forEach((item) {
      latestSubjectList.add(Subject.fromJson(item));
    });
    notifyListeners();
  }

  // 根据关键字查询帖子列表
  //todo:需要加个anchor,锚，有锚，则是加载更多
  getPostListWithKeyword(String keyword) async {
    ListResp listResp = await Api.instance
        .searchWithKeyword(keyword, Constants.searchTypeThread);
    postCount = listResp.count ?? 0;
    //有锚，则不posts.clear();
    postList.clear();
    listResp.list?.forEach((item) {
      postList.add(Post.fromJson(item));
    });
    notifyListeners();
  }

  List<Subject> subjectList = [];
  int subjectCount = 0;

// 根据关键词查询subject列表
  // 需要锚
  getSubjectListWithKeyword(String keyword) async {
    ListResp listResp = await Api.instance
        .searchWithKeyword(keyword, Constants.searchTypeSubject);
    subjectCount = listResp.count ?? 0;
    // 有锚则不清空
    subjectList.clear();
    listResp.list?.forEach((item) {
      subjectList.add(Subject.fromJson(item));
    });
    print("subject数量：$subjectCount");
    notifyListeners();
  }

  List<User> userList = [];
  int userCount = 0;
// 根据关键字查询user列表
  // 需要锚
  getUserListWithKeyword(String keyword) async {
    ListResp listResp =
        await Api.instance.searchWithKeyword(keyword, Constants.searchTypeUser);
    userCount = listResp.count ?? 0;
    // 有锚则不清空
    userList.clear();
    listResp.list?.forEach((item) {
      userList.add(User.fromJson(item));
    });
    notifyListeners();
  }
}
