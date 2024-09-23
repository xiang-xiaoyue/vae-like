import 'package:flutter/material.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/group_simple.dart';
import 'package:trump/service/api.dart';

class SearchGroupListViewModel with ChangeNotifier {
  SearchGroupListViewModel() {
    getGroupSimpleList().then((_) {
      filterList("");
    });
  }

  List<GroupSimple> list = [];
  List<GroupSimple> filteredList = [];

  Future getGroupSimpleList() async {
    ListResp listResp = await Api.instance.getGroupList();
    listResp.list?.forEach((i) {
      list.add(GroupSimple.fromJson(i));
    });
    notifyListeners();
  }

  filterList(String keyword) {
    if (keyword == "") {
      filteredList = list;
      notifyListeners();
      return;
    }
    filteredList = list
        .where(
          (item) => item.name.contains(keyword) || item.brief.contains(keyword),
        )
        .toList();
    notifyListeners();
  }
}
