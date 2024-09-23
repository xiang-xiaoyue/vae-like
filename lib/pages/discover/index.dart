//发现
// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/bottom_navigator_bar.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/pages/discover/sub/task_center/vm.dart';
import 'package:trump/pages/discover/vm.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TrumpBottomNavigatorBar(),
      body: Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Container(
                height: 240,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/5.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          ChangeNotifierProvider<DiscoverViewModel>(
            create: (context) => DiscoverViewModel(),
            child: Positioned(
              left: 0,
              right: 0,
              top: 200,
              child: Column(
                children: [
                  _MenuItemWrapper(list: [
                    _MenuItem(
                      icon: Icons.search,
                      text: "输入对方的ID号或昵称",
                      pathName: "search",
                      queryParameters: {"type": Constants.searchTypeUser},
                    ),
                  ]),
                  _MenuItemWrapper(list: [
                    _MenuItem(
                      icon: Icons.location_on,
                      text: "附近的人",
                      pathName: "search",
                      queryParameters: {"type": "nearby"},
                    ),
                    _MenuItem(
                      icon: Icons.group,
                      text: "发现群组",
                      pathName: "search",
                      queryParameters: {"type": "group"},
                    ),
                  ]),
                  /*
                  _MenuItemWrapper(list: [
                    _MenuItem(
                      icon: Icons.home,
                      text: "Trump+直播间",
                      pathName: "live",
                    ),
                  ]),
                  */
                  _MenuItemWrapper(list: [
                    Consumer<DiscoverViewModel>(builder: (context, vm, _) {
                      return _MenuItem(
                        icon: Icons.check,
                        text: "每日签到",
                        tailText: vm.isCheckedIn ? "已签到" : "未签到",
                        pathName: "sign",
                      );
                    }),
                    Consumer<DiscoverViewModel>(builder: (context, vm, _) {
                      return _MenuItem(
                        icon: Icons.task,
                        text: "任务中心",
                        tailText: "完成度${vm.taskProgress}%",
                        pathName: "task_center",
                      );
                    }),
                    _MenuItem(
                      icon: Icons.sort_by_alpha,
                      text: "排行榜",
                      pathName: "user_rank",
                    ),
                    _MenuItem(
                      icon: Icons.shop,
                      text: "商城",
                      pathName: "shop",
                    ),
                    _MenuItem(
                      icon: Icons.home,
                      text: "最热帖排行",
                      pathName: "post_rank_list",
                    ), //最热帖子排行
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItemWrapper extends StatelessWidget {
  final List<Widget> list;
  const _MenuItemWrapper({required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: list,
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String tailText;
  final String pathName;
  final Map<String, dynamic> queryParameters;
  const _MenuItem({
    required this.icon,
    required this.text,
    required this.pathName,
    this.tailText = "",
    this.queryParameters = const {},
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(pathName, queryParameters: queryParameters);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        height: 55,
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(fontSize: 20, height: 2),
            ),
            const Spacer(),
            Text(tailText),
          ],
        ),
      ),
    );
  }
}
