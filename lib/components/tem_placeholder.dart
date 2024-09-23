import 'package:flutter/material.dart';

class TemPlaceholder extends StatelessWidget {
  final String text;
  const TemPlaceholder({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 70, fontWeight: FontWeight.w800),
      ),
    );
  }
}
