import 'package:flutter/foundation.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/service/api.dart';

class SearchResultViewModel with ChangeNotifier {
  SearchResultViewModel.init(String type) {
    getLatestPostList(type: type);
    getHotPostList(type: type);
    notifyListeners();
  }
  List<Post> latestPostList = []; // 最新
  int latestPostCount = 0;

  List<Post> hotPostList = []; // 最热
  int hotPostCount = 0;

  Future getLatestPostList(
      {String type = Constants.postSubTypeShortText}) async {
    ListResp listResp = await Api.instance.getPostList(
      postType: Constants.postTypeThread,
      postSubType: type,
    );
    latestPostCount = listResp.count ?? 0;
    latestPostList.clear();
    listResp.list?.forEach((item) {
      latestPostList.add(Post.fromJson(item));
    });
    notifyListeners();
  }

  //todo: 用热度排行
  Future getHotPostList({String type = Constants.postSubTypeShortText}) async {
    ListResp listResp = await Api.instance.getPostList(
      postType: Constants.postTypeThread,
      postSubType: type,
    );

    hotPostCount = (listResp.count ?? 0);
    hotPostList.clear();
    listResp.list?.forEach((item) {
      hotPostList.add(Post.fromJson(item));
    });
    notifyListeners();
  }
}
