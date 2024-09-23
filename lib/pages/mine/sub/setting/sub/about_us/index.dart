import 'package:flutter/material.dart';
import 'package:trump/components/app_bar.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CommonAppBar(title: "关于我们"),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 80),
            Text(
              "关于软件",
              style: TextStyle(fontSize: 30),
            ),
            Text("灵感来自ave"),
          ],
        ),
      ),
    );
  }
}
