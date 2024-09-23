import 'package:flutter/material.dart';
import 'package:trump/components/index.dart';

// 纪念卡
class MineAnnversaryCardsPage extends StatelessWidget {
  const MineAnnversaryCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "纪念卡"),
      body: Center(
        child: Text("纪念卡"),
      ),
    );
  }
}
