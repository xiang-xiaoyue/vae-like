import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/pages/mine/vm.dart';
import './vm.dart';
import 'package:trump/pages/notice/components/go_back_leading.dart';
import 'package:trump/pages/search/components/user_item.dart';

// 粉丝与关注页面
class FansPage extends StatelessWidget {
  final String id; // todo: id是当前用户的id,这里没用到
  final String isFan;
  const FansPage({super.key, required this.id, required this.isFan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<CurrentUserViewModel>(builder: (context, curUser, child) {
        return curUser.user != null
            ? SafeArea(
                child: ChangeNotifierProvider<FansPageViewModel>(
                  create: (context) {
                    return FansPageViewModel(curUser.user!.id);
                  },
                  child: Stack(
                    children: [
                      Positioned(
                          child: _Page(initialIndex: isFan == "true" ? 1 : 0)),
                      const MsgGoBackLeading(),
                    ],
                  ),
                ),
              )
            : const SizedBox();
      }),
    );
  }
}

class _Page extends StatelessWidget {
  final int initialIndex;
  const _Page({super.key, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: initialIndex,
      length: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Consumer<FansPageViewModel>(builder: (context, vm, child) {
          return Column(
            children: [
              //todo: twotabappbar的indicator看起来有圆角，不是方正的。
              const TwoTabAppBar(leftText: "粉丝", rightText: "关注"),
              const SizedBox(height: 8),
              CommonSearchTextField(
                hintText: "输入用户名或用户ID号",
                borderRadiusSize: 4,
                onChange: (v) {
                  return vm.filterFans(v);
                },
              ),
              const SizedBox(height: 8),
              Expanded(
                child: TabBarView(
                  children: [
                    ListView.builder(
                        itemCount: vm.fans.length,
                        itemBuilder: (ctx, idx) {
                          return SearchUserItem(
                            user: vm.fans[idx],
                            rightOnTap: () => vm.toggleFollowFan(vm.fans[idx]),
                          );
                        }),
                    ListView.builder(
                        itemCount: vm.followingUsers.length,
                        itemBuilder: (ctx, idx) {
                          return SearchUserItem(
                            user: vm.followingUsers[idx],
                            rightOnTap: () {
                              vm.cancelFollowUser(vm.followingUsers[idx]);
                            },
                          );
                        }),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
