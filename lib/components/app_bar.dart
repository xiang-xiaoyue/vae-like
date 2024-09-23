import 'package:flutter/material.dart';
import 'package:trump/components/leading.dart';
import 'package:trump/configs/const.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final TabBar? bottom;
  final double appBarHeight;
  final double rightPadding;
  final Color backgrounColor;
  final double titleOpacity;
  const CommonAppBar({
    super.key,
    required this.title,
    this.titleOpacity = 1,
    this.actions = const [],
    this.bottom,
    this.appBarHeight = 48,
    this.rightPadding = 16.0,
    this.backgrounColor = Colors.white,
  });

  @override
  //Size get preferredSize => Size.fromHeight(kToolbarHeight);
  Size get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const GoBackLeading(),
      leadingWidth: TrumpSize.leadingWidth,
      backgroundColor: backgrounColor,
      titleSpacing: 0,
      titleTextStyle: TrumpCommon.appBarTitleStyle,
      elevation: 0,
      title: Opacity(opacity: titleOpacity, child: Text(title)),
      actions: [...actions, SizedBox(width: rightPadding)],
      bottom: bottom,
      // sliverappbar吸顶时会有阴影显示，elevation:0也无用。此处用0就不会有阴影。
      scrolledUnderElevation: 0,
    );
  }
}

// 搭配defaultTabController和tabbarview使用
class TwoTabAppBar extends StatelessWidget {
  final String leftText;
  final String rightText;
  const TwoTabAppBar({
    super.key,
    this.leftText = "帖子@我",
    this.rightText = "评论@我",
  });

  //todo: 这里的indicator像个梯形，但我想要的是小矩形。
  @override
  Widget build(BuildContext context) {
    const activeStyle = TextStyle(
        color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 14);
    const inactiveStyle = TextStyle(color: Colors.grey, fontSize: 14);
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: TabBar(
        dividerColor: Colors.transparent,
        indicatorPadding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        indicatorColor: Colors.blue,
        labelStyle: activeStyle,
        unselectedLabelStyle: inactiveStyle,
        indicatorWeight: 0.5,
        tabAlignment: TabAlignment.center,
        isScrollable: true,
        tabs: [
          Tab(child: Text(leftText)),
          Tab(child: Text(rightText)),
        ],
      ),
    );
  }
}
