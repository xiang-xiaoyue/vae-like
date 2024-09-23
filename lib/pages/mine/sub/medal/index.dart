import 'package:flutter/material.dart';
import 'package:trump/components/app_bar.dart';

// 勋章页面
class MineMedalsPage extends StatelessWidget {
  const MineMedalsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "勋章"),
      body: Center(
        child: Text("勋章"),
      ),
    );
  }
}
