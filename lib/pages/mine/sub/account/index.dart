import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/avatar.dart';
import 'package:trump/components/leading.dart';
import 'package:trump/fonts/index.dart';
import 'package:trump/pages/mine/vm.dart';

var _decoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(8),
);

// 我的帐户
class MineAccountPage extends StatelessWidget {
  const MineAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    var toHelpPage = TextButton(
      onPressed: () => context.pushNamed("help_center"),
      child: const Text(
        "帮助",
        style: TextStyle(color: Colors.white),
      ),
    );
    var appbar = AppBar(
      leading: const GoBackLeading(color: Colors.white),
      backgroundColor: Colors.blue[700],
      titleTextStyle: const TextStyle(fontSize: 20, color: Colors.white),
      titleSpacing: 0,
      title: const Text("我的帐户"),
      actions: [toHelpPage],
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //头部显示各种货币的余额
            Consumer<CurrentUserViewModel>(builder: (context, vm, child) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 36),
                color: Colors.blue[700],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _WealthItem(
                        text: "金币",
                        count: vm.user!.currency['coin'] ?? 0,
                        icon: TCIcons.money),
                    _WealthItem(
                        text: "松果",
                        count: vm.user!.currency['cash'] ?? 0,
                        icon: TCIcons.cash),
                    _WealthItem(
                        text: "经验",
                        count: vm.user!.currency['exp'] ?? 0,
                        icon: TCIcons.exp),
                  ],
                ),
              );
            }),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: _decoration,
              child: Column(
                children: [
                  _MenuItem(
                      text: "我的订单", onTab: () => context.pushNamed("pay_note")),
                  _MenuItem(
                      text: "我的收益", onTab: () => context.pushNamed("income")),
                  _MenuItem(
                      text: "购买松果", onTab: () => context.pushNamed("charge")),
                  _MenuItem(
                      text: "身份认证", onTab: () => context.pushNamed("identity")),
                ],
              ),
            ),
            //_PropPanel(), //我的道具
            TextButton.icon(onPressed: null, label: const Text("身份认证")),
            Container(),
          ],
        ),
      ),
    );
  }
}

class _PropPanel extends StatelessWidget {
  const _PropPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _decoration,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("我的道具"),
              GestureDetector(
                child: const Text("帮助"),
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _PropItem(),
              _PropItem(),
              _PropItem(),
            ],
          ),
        ],
      ),
    );
  }
}

class _PropItem extends StatelessWidget {
  const _PropItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomAvatar(
          size: 64,
          radius: 8,
        ),
        SizedBox(height: 4),
        Text("补签卡:0"),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String text;
  final VoidCallback? onTab;
  const _MenuItem({
    super.key,
    this.onTab,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTab,
      title: Text(text),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}

class _WealthItem extends StatelessWidget {
  final String text;
  final int count;
  final IconData icon;
  const _WealthItem({
    required this.text,
    required this.count,
    this.icon = TCIcons.lock,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 40, color: Colors.white70),
        const SizedBox(height: 16),
        Text(
          "$count",
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
