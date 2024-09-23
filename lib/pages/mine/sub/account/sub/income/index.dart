import 'package:flutter/material.dart';
import 'package:trump/components/exports.dart';

// 我的收益
// todo:
class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "我的收益"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            "收益应当是发布付费帖子后获得的金币",
            style: TextStyle(),
            textScaler: TextScaler.linear(2),
          ),
        ),
      ),
    );
  }
}
