import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoBackLeading extends StatelessWidget {
  final Color color;
  const GoBackLeading({super.key, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pop();
      },
      child: Icon(Icons.chevron_left_sharp, color: color),
    );
  }
}
