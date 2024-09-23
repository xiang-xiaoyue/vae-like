import 'package:flutter/material.dart';
import 'package:trump/components/buttons/button.dart';
import 'package:trump/components/index.dart';
import 'package:trump/fonts/index.dart';

//充值页面/购买松果/充值余额
class ChargePage extends StatelessWidget {
  const ChargePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: "松果铺子",
        actions: [
          TextButton(
            onPressed: null,
            child: Text(
              "购买记录",
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(
              TCIcons.help,
              color: Colors.blue,
              size: 24,
            ),
          ),
        ],
        rightPadding: 0,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 180,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                opacity: 0.7,
                image: AssetImage("assets/images/1.jpg"),
              ),
            ),
            child: const Text("松果铺子", style: TextStyle(fontSize: 45)),
          ),
          const _PayCardItem(cashCount: 60, extraCashCount: 5, rmb: 6),
          const _PayCardItem(cashCount: 310, extraCashCount: 30, rmb: 30),
          const _PayCardItem(cashCount: 720, extraCashCount: 80, rmb: 68),
          const _PayCardItem(cashCount: 1368, extraCashCount: 200, rmb: 128),
        ],
      ),
    );
  }
}

class _PayCardItem extends StatelessWidget {
  final int cashCount;
  final int extraCashCount;
  final int rmb;
  const _PayCardItem({
    super.key,
    this.cashCount = 60,
    this.extraCashCount = 5,
    this.rmb = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        title: Text(
          "$cashCount 颗松果",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          "VIP额外加$extraCashCount",
          style: const TextStyle(fontSize: 14, color: Colors.blue),
        ),
        trailing: TrumpButton(
          width: 65,
          height: 40,
          borderRadius: 4,
          text: "￥$rmb",
          backgroundColor: Colors.blue,
          textColor: Colors.white,
        ),
      ),
    );
  }
}
