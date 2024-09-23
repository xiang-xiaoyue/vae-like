// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/app_bar.dart';
import 'package:trump/components/buttons/button.dart';
import 'package:trump/fonts/index.dart';
import 'package:trump/pages/mine/sub/invite_friend/vm.dart';
import 'package:trump/pages/mine/vm.dart';

//todo: 二维码扫码邀请
class MineInviteFriendsPage extends StatelessWidget {
  const MineInviteFriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isExpired(int createTime) {
      return DateTime.fromMillisecondsSinceEpoch(createTime)
              .add(const Duration(hours: 48))
              .millisecondsSinceEpoch <
          DateTime.now().millisecondsSinceEpoch;
    }

    var appBar = CommonAppBar(
      title: "邀请好友(待开发)",
      actions: [
        Icon(
          Icons.question_mark,
          color: Colors.blue[200],
        ),
        const SizedBox(width: 16),
      ],
    );
    return ChangeNotifierProvider<InviteViewModel>(
      create: (context) => InviteViewModel(),
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<InviteViewModel>(builder: (context, vm, _) {
                return Consumer<CurrentUserViewModel>(
                    builder: (context, curUser, _) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    color: Colors.white,
                    child: Container(
                      color: Colors.grey.shade200,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: vm.inviter != null
                          ? Text("邀请者id:${vm.inviter!.id}")
                          : isExpired(curUser.user?.createTime ?? 0)
                              ? const Text("注册已过48小时，无法填写邀请码")
                              : const _inputInviteCode(),
                    ),
                  );
                });
              }),
              Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: Consumer<CurrentUserViewModel>(
                    builder: (context, curUser, _) {
                  return Column(
                    children: [
                      Text("您的邀请码:${curUser.user?.id ?? 0}"),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 64, vertical: 8),
                        child: TrumpButton(
                          text: "邀请好友",
                          textColor: Colors.white,
                          backgroundColor: Colors.blue.shade500,
                          borderRadius: 4,
                          textSize: 18,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                }),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                color: Colors.white,
                child: const Column(
                  children: [
                    _InviteTipHeader(),
                    SizedBox(height: 8),
                    _InviteTipItem(userCount: 1, coin: 50, cash: 5),
                    _InviteTipItem(userCount: 5, coin: 100, cash: 10),
                    _InviteTipItem(userCount: 10, coin: 150, cash: 15),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("贴心提示"),
                    Text("1. 被邀请的好友账号必须为新注册的账号"),
                    Text("2. 新注册用户在注册后48小时内填写邀请码才有效，超时无法再填写"),
                    Text("3. 下载APP后，进入“我”-“邀请好友得好礼”页面，填写邀请码验证成功后即可领取福利"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InviteTipHeader extends StatelessWidget {
  const _InviteTipHeader();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "邀请好友领奖(暂时不支持领奖)",
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class _InviteTipItem extends StatelessWidget {
  final int userCount;
  final int coin;
  final int cash;
  const _InviteTipItem({
    this.userCount = 1,
    this.coin = 5,
    this.cash = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("邀请$userCount个用户且你自己的等级到3级"),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(TCIcons.money, color: Colors.yellow),
                  Text("+$coin"),
                  const SizedBox(width: 16),
                  const Icon(TCIcons.cash, color: Colors.brown),
                  Text("+$cash"),
                ],
              ),
            ],
          ),
          Consumer<InviteViewModel>(builder: (context, vm, _) {
            return Consumer<CurrentUserViewModel>(
                builder: (context, curUser, _) {
              return TrumpButton(
                text: (vm.beInvitedCount >= userCount &&
                        (curUser.user?.level ?? 0) >= 3)
                    ? "已达成"
                    : "0/1",
                width: 60,
                height: 30,
                borderRadius: 4,
              );
            });
          }),
        ],
      ),
    );
  }
}

class _inputInviteCode extends StatelessWidget {
  const _inputInviteCode();

  @override
  Widget build(BuildContext context) {
    return Consumer<InviteViewModel>(builder: (context, vm, child) {
      return Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (v) => vm.code = v,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                border: InputBorder.none,
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),
          TrumpButton(
            height: 48,
            margin: const EdgeInsets.only(left: 16),
            borderStyle: BorderStyle.none,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            backgroundColor: Colors.orange.shade400,
            borderRadius: 4,
            text: "领取",
            textSize: 18,
            fontWeight: FontWeight.w500,
            textColor: Colors.white,
            onTap: () {
              vm.beInvited();
            },
          ),
        ],
      );
    });
  }
}
