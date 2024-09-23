import 'package:flutter/material.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/models/post.dart';
import 'package:trump/models/resp/resp.dart';
import 'package:trump/service/api.dart';

// 获取行程列表
class TripListViewModel with ChangeNotifier {
  TripListViewModel() {
    getTripList();
  }
  List<Post> trips = [];
  int tripCount = 0;

  Future getTripList() async {
    ListResp listResp = await Api.instance.getPostList(
      postType: Constants.postTypeTrip,
    );
    tripCount = listResp.count ?? 0;
    listResp.list?.forEach((item) {
      trips.add(Post.fromJson(item));
    });
    notifyListeners();
  }
}
