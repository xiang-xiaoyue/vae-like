import 'package:flutter/material.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/pages/search/sub/group/index.dart';
import 'package:trump/pages/search/sub/nearby/index.dart';
import './sub/user/index.dart';
import './sub/main/index.dart';

class SearchPage extends StatelessWidget {
  final String type;
  const SearchPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    // 搜索用户的界面
    if (type == Constants.searchTypeUser) {
      return const SearchUserPage();
      // 搜索群组的界面
    } else if (type == Constants.searchTypeGroup) {
      return const SearchGroupPage();
      // 搜索附近的人的界面
    } else if (type == "nearby") {
      return const SearchNearbyPage();
    } else {
      // 主搜索页面
      return const SearchMainPage();
    }
  }
}
