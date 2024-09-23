import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/pages/discover/sub/user_rank_detail/vm.dart';
import 'package:trump/pages/notice/export.dart';

// 具体的用户相关的排行榜页面
class UserRankDetailPage extends StatelessWidget {
  final String type;
  const UserRankDetailPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    Map<String, String> maps = {
      "hot": "人气榜",
      "checkin": "签到榜",
      "level": "等级榜",
      "coin": "金币榜",
    };
    var textStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
    );
    var heightWhite = SliverToBoxAdapter(
      child: Container(height: 16, color: Colors.white),
    );
    return Scaffold(
      appBar: CommonAppBar(
        title: maps[type]!,
        rightPadding: 0,
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.open_in_new, color: Colors.blue, size: 24),
          ),
        ],
      ),
      body: ChangeNotifierProvider<RankDetailViewModel>(
        create: (context) => RankDetailViewModel(type),
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                _Header(maps: maps, sortType: type),
                // 人气榜切换tab menu
                //const _TabBar(),

                // 指明表单每多少时间更新
                const _RankTimeInfo(),

                // 榜单中的用户列表
                _ListSection(type: type),
                // PageView(
                //   children: [
                //     KeepAliveWrapper(child: _ListSection()),
                //     KeepAliveWrapper(child: _ListSection()),
                //     KeepAliveWrapper(child: _ListSection()),
                //   ],
                // ),
                const SliverToBoxAdapter(
                  child: Column(
                    children: [
                      NoMore(),
                      SizedBox(height: 60),
                    ],
                  ),
                ),
              ],
            ),
            _Bottom(textStyle: textStyle), // "我"是否进入榜单
          ],
        ),
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom({
    super.key,
    required this.textStyle,
  });

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.blue,
        height: 64,
        //todo: 获取当前用户信息
        child: Row(
          children: [
            const CustomAvatar(
              size: 48,
              radius: 8,
            ),
            const SizedBox(width: 16),
            Text("我", style: textStyle),
            const SizedBox(width: 8),
            Text("未进入榜单", style: textStyle),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    super.key,
    required this.maps,
    required this.sortType,
  });

  final Map<String, String> maps;
  final String sortType;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 160,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home_outlined, color: Colors.blue, size: 140),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maps[sortType]!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text("想进榜单"),
                const Text("快去看看如何获得人气?"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RankTimeInfo extends StatelessWidget {
  const _RankTimeInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      // 榜单更新频次说明
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: const Text("榜单每20分钟更新一次"),
      ),
    );
  }
}

// 列表主体部分
class _ListSection extends StatelessWidget {
  final String type;
  const _ListSection({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RankDetailViewModel>(builder: (context, vm, child) {
      return SliverList.separated(
        separatorBuilder: (context, index) => Divider(
          height: 1,
          indent: 16,
          endIndent: 16,
          color: Colors.grey.shade100,
        ),
        itemCount: vm.users.length,
        itemBuilder: (context, index) {
          return _RankUserItem(type: type, index: index, user: vm.users[index]);
        },
      );
    });
  }
}

class _RankUserItem extends StatelessWidget {
  final String type;
  final int index;
  final User user;
  const _RankUserItem({
    super.key,
    required this.user,
    required this.index,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // todo: 如果用boxdecoration做底部border,会感觉每条粗细不同，似乎奇数的边框和偶数边框粗细不同。
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 80,
      color: Colors.white,
      child: Row(
        children: [
          Text(
            "${index + 1}",
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 16),
          //  const CustomAvatar(size: 48, radius: 4),
          UserAvatar(url: user.avatarUrl, size: 48, radius: 4),
          const SizedBox(width: 16),
          Text(user.name),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _getExtraInfo(type, user),
          ),
        ],
      ),
    );
  }

  List<Widget> _getExtraInfo(String type, User user) {
    switch (type) {
      case "hot":
        return [
          Text("今日人气0"),
          Text("总人气0"),
        ];
      case "level":
        return [
          Text("${user.level}"),
        ];
      case "coin":
        return [
          Text("金币"),
          Text("${user.currency['coin']}"),
        ];

      case "checkin":
        return [
          Text("连续签到${user.seriesCheckinDays}天"),
          Text("总签到${user.totalCheckinDays}天"),
        ];
      default:
        return [
          Text("未知"),
          Text("未知"),
        ];
    }
  }
}

// 日榜、周榜、总榜菜单切换
class _TabBar extends StatefulWidget {
  const _TabBar({super.key});

  @override
  State<_TabBar> createState() => _TabBarState();
}

class _TabBarState extends State<_TabBar> with SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 0;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this, initialIndex: index);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeaderDelegate(
        maxHeight: 72,
        minHeight: 72,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          color: Colors.white,
          child: StatefulBuilder(builder: (context, setState) {
            return TabBar(
              controller: controller,
              automaticIndicatorColorAdjustment: true,
              labelPadding: const EdgeInsets.all(0),
              dividerHeight: 0,
              labelStyle: const TextStyle(color: Colors.purple, fontSize: 20),
              padding: const EdgeInsets.symmetric(horizontal: 0),
              // note: 之前点击自定义的tab无法激活，用StatefulBuilder包裹TabBar就好了，这里的setState换成局部的setState
              // 之前百思不得其解，查询“自定义tab无效”，tabbarview用法之类的，但得到的都是入门文章，浪费时间,又查询“Tab()的child用法”，
              // 结果那些文章都没讲Tab()的child怎么用 。
              // todo: setState()要求其作用对象必须是一个有状态的组件。如果作用对象本身无状态，那么setState()将无法起作用。             // 最后，谷歌连不上,尝试在掘金查询“flutter setState无效”,找到解决方案。
              // 难道是因为上面的container是statelesswidget?
              // 可是tabbar本身又是statefulWidget,它里面的onTap用了setState应该有用才对。
              /// 偶然看到文章说：
              // statefulWidget不需要你自己管理状态，而是通过提供一个构建函数来动态构建widget
              //statefulWidget可根据应用的状态动态构建widget.
              onTap: (value) {
                index = value;
                controller.index = index;
                setState(() {});
              },
              indicator: const BoxDecoration(),
              tabs: [
                TabMenuItem(text: "日榜", leftRadius: true, isActive: index == 0),
                TabMenuItem(text: "周榜", isActive: index == 1),
                TabMenuItem(
                    text: "总榜", rightRadius: true, isActive: index == 2),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class TabMenuItem extends StatelessWidget {
  final String text;
  final bool leftRadius;
  final bool rightRadius;
  final bool isActive;
  const TabMenuItem({
    super.key,
    required this.text,
    this.leftRadius = false,
    this.rightRadius = false,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      //height: 40,
      decoration: BoxDecoration(
        color: isActive ? Colors.grey.shade500 : Colors.white,
        border: Border.all(width: 0.5, color: Colors.grey),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(leftRadius ? 8 : 0),
          bottomLeft: Radius.circular(leftRadius ? 8 : 0),
          topRight: Radius.circular(rightRadius ? 8 : 0),
          bottomRight: Radius.circular(rightRadius ? 8 : 0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: isActive ? Colors.white : Colors.grey, fontSize: 18),
      ),
    );
  }
}
