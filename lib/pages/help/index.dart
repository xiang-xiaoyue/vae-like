import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:trump/components/app_bar.dart';
import 'package:trump/components/leading.dart';

// 帮助中心
class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "TC帮助中心"),
      // body: Column(
      //   children: [
      //     SizedBox(height: 2),
      //     Expanded(
      //       child: ListView.separated(
      //         shrinkWrap: true,
      //         itemBuilder: (context, index) {
      //           return _Item(text: "帮助中心");
      //         },
      //         separatorBuilder: (context, index) {
      //           return Divider(
      //             height: 1,
      //             indent: 16,
      //             color: Colors.grey[300],
      //           );
      //         },
      //         itemCount: 20,
      //       ),
      //     ),
      //   ],
      // ),
      body: Center(child: Text("待做...", style: TextStyle(fontSize: 30))),
    );
  }
}

class _Item extends StatelessWidget {
  final String text;
  const _Item({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(fontSize: 18),
        ),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}
