import 'package:flutter/material.dart';
import 'package:trump/models/resp/models/subject.dart';

class SubjectItem extends StatelessWidget {
  final Subject subject;
  const SubjectItem({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.grey.withAlpha(100)),
        ),
      ),
      height: 80,
      child: Row(
        children: [
          const Text(
            "#",
            style: TextStyle(color: Colors.blue, fontSize: 18),
          ),
          const SizedBox(width: 12),
          Text(
            subject.name,
            style: const TextStyle(fontSize: 18),
            // note:让英文符号与中文对齐
            strutStyle: const StrutStyle(forceStrutHeight: true, leading: 0.5),
          ),
          const Spacer(),
          const Text(
            "10000点热度",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
