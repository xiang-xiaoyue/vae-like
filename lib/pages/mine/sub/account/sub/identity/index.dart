import 'package:flutter/material.dart';
import 'package:trump/components/index.dart';

// 身份认证
class IdentityPage extends StatelessWidget {
  const IdentityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "身份认证"),
      body: Center(
        child: Text("输入姓名与身份证号"),
      ),
    );
  }
}
