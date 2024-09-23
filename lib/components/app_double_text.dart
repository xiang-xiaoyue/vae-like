// ignore_for_file: avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDoubleText extends StatelessWidget {
  final String left;
  final String right;
  final VoidCallback? onTap;
  const AppDoubleText({
    super.key,
    required this.left,
    required this.right,
    this.onTap = null,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          left,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        GestureDetector(
          //onTap: onTap ?? () => context.pushNamed("title_role"),
          onTap: onTap == null
              ? () => context.pushNamed("hot_user_content_list")
              : () => onTap,
          child: Text(
            right,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}

class AppTextAndIcon extends StatelessWidget {
  final String left;
  final IconData right;
  final VoidCallback? onTap;
  const AppTextAndIcon({
    super.key,
    required this.left,
    required this.right,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          left,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        GestureDetector(
          // onTap: () {
          //   onTap == null ? context.pushNamed("title_role") : onTap;
          // },
          onTap: onTap ?? () => context.pushNamed("title_role"),
          child: Icon(right, size: 18),
        ),
      ],
    );
  }
}
