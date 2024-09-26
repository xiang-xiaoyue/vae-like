import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/pages/mine/vm.dart';
import 'package:trump/pages/notice/components/go_back_leading.dart';
import 'package:trump/pages/notice/components/item_card.dart';
import 'package:trump/pages/notice/vm.dart';

//todo: 来此页面之前，应该判断有无登录，未登录则跳转到登录页面。
// 其他很多页面同理。
class LikeNoticePage extends StatelessWidget {
  const LikeNoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: const SafeArea(
        child: Stack(
          children: [
            Positioned(child: _Page()),
            MsgGoBackLeading(),
          ],
        ),
      ),
    );
  }
}

// 赞帖子、评论、活动、行程、官方动态（新闻）
// 赞用户在别的地方
class _Page extends StatelessWidget {
  const _Page();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TwoTabAppBar(
            leftText: "赞我的",
            rightText: "我赞的",
          ),
          Expanded(
            child: Consumer<CurrentUserViewModel>(
                builder: (context, curUser, child) {
              return curUser.user != null
                  ? Consumer<NoticeIndexViewModel>(
                      builder: (context, vm, child) {
                      return TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ListView.builder(
                            padding: const EdgeInsets.only(bottom: 32, top: 4),
                            itemBuilder: (ctx, idx) => NoticeItem(
                              notice: vm.likeMeList[idx],
                              callback: () async => await vm.getLikeList(),
                            ),
                            itemCount: vm.likeMeList.length,
                          ),
                          ListView.builder(
                            itemBuilder: (ctx, idx) => NoticeItem(
                              notice: vm.myLikeList[idx],
                              callback: () async => await vm.getLikeList(),
                            ),
                            itemCount: vm.myLikeList.length,
                          ),
                        ],
                      );
                    })
                  : const SizedBox();
            }),
          ),
        ],
      ),
    );
  }
}
