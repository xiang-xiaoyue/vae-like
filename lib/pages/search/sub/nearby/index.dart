import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trump/components/index.dart';

//附近的人
class SearchNearbyPage extends StatelessWidget {
  const SearchNearbyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "附近的人"),
      body: Center(
        child: TextButton(
          onPressed: () => context.pop(),
          child: const Text(
            "待开发...",
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
