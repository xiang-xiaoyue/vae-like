import 'package:flutter/material.dart';
import 'package:trump/components/index.dart';
import 'package:trump/configs/const.dart';

// 作品页面
class WorkListPage extends StatelessWidget {
  const WorkListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CommonAppBar(title: "作品", backgrounColor: Constants.backgroundColor),
      body: Center(
        child: Text(
          "待做...",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
