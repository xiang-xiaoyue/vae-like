import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/pages/discover/sub/user_rank/vm.dart';

// 用户排行榜
class UserRankPage extends StatelessWidget {
  const UserRankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: const CommonAppBar(title: "排行榜"),
      body: ChangeNotifierProvider<UserRankIndexViewModel>(
        create: (context) => UserRankIndexViewModel(),
        child: Consumer<UserRankIndexViewModel>(builder: (context, vm, child) {
          return Column(
            children: [
              if (vm.hotUsers.isNotEmpty)
                _RankTabItem(
                  title: "人气榜",
                  sortType: "hot",
                  users: vm.hotUsers.length > 4
                      ? vm.hotUsers.sublist(0, 4)
                      : vm.hotUsers,
                ),
              if (vm.checkinUsers.isNotEmpty)
                _RankTabItem(
                  title: "签到榜",
                  sortType: "checkin",
                  users: vm.checkinUsers.length > 4
                      ? vm.checkinUsers.sublist(0, 4)
                      : vm.checkinUsers,
                ), //todo: 根据连续签到、总签到和签到顺序等 计算
              if (vm.levelUsers.isNotEmpty)
                _RankTabItem(
                  title: "等级榜",
                  sortType: "level",
                  users: vm.levelUsers.length > 4
                      ? vm.levelUsers.sublist(0, 4)
                      : vm.levelUsers,
                ), //本质按经验值排名
              if (vm.coinUsers.isNotEmpty)
                _RankTabItem(
                    title: "金币榜",
                    sortType: "coin",
                    users: vm.coinUsers.length > 4
                        ? vm.coinUsers.sublist(0, 4)
                        : vm.coinUsers), //金币榜
            ],
          );
        }),
      ),
    );
  }
}

class _RankTabItem extends StatelessWidget {
  final String title;
  final String sortType;
  final List<User> users;
  const _RankTabItem({
    super.key,
    required this.title,
    required this.sortType,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed("user_rank_detail",
          queryParameters: {"sort_type": sortType}),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        margin: const EdgeInsets.only(top: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...users.map((i) {
                  return _UserItem(avatar: i.avatarUrl, name: i.name);
                }),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child:
                      Icon(Icons.chevron_right, size: 32, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _UserItem extends StatelessWidget {
  final String name;
  final String avatar;
  const _UserItem({
    super.key,
    required this.name,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          UserAvatar(
            url: avatar,
            hintText: "无图",
            size: 50,
          ),
          const SizedBox(height: 8),
          Text(
            softWrap: false,
            maxLines: 1,
            name.length > 3 ? "${name.substring(0, 3)}..." : name,
          )
        ],
      ),
    );
  }
}
