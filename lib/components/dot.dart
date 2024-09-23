// 小圆点，需要半径和颜色
import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  final double radius;
  final Color color;
  const Dot({
    super.key,
    required this.radius,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius * 2,
      width: radius * 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(width: radius, color: color),
      ),
    );
  }
}
