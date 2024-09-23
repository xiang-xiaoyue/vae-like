import 'package:flutter/material.dart';
import 'package:trump/components/tem_placeholder.dart';

// 直播间列表页面
class LivePage extends StatelessWidget {
  const LivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemPlaceholder(
        text: "live page",
      ),
    );
  }
}
