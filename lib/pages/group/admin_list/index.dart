import 'package:flutter/material.dart';
import 'package:trump/components/app_bar.dart';
import 'package:trump/components/user/group_member_item.dart';

// 群主/管理员列表页面
class GroupAdminListPage extends StatelessWidget {
  final String id;
  const GroupAdminListPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "群主/管理员"),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return const GroupMemberItem();
        },
      ),
    );
  }
}
