import 'package:flutter/material.dart';
import 'package:trump/components/search/app_bar.dart';
import 'package:trump/components/user/group_member_item.dart';
import 'package:trump/configs/const.dart';

// 群组成员列表页面
//todo: 索引条
class GroupMemberListPage extends StatelessWidget {
  final String id;
  const GroupMemberListPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            ListView.builder(
              padding: EdgeInsets.only(top: TrumpSize.searchAppBarHeight),
              itemCount: 100,
              itemBuilder: (context, index) {
                return GroupMemberItem();
              },
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: SearchAppBar(),
            ),
          ],
        ),
      ),
    );
  }
}
