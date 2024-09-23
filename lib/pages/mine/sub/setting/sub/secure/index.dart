// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trump/components/app_bar.dart';

class SecurePage extends StatelessWidget {
  const SecurePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: "安全设置",
      ),
      body: Column(
        children: [
          const SizedBox(height: 4),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                _Item(
                  text: "修改密码",
                  onTap: () => context.pushNamed("update_pwd"),
                ),
                Divider(color: Colors.grey[300], height: 0, thickness: 0.5),
                _Item(
                  text: "注销帐号",
                  onTap: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("暂不支持")));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const _Item({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
