import 'package:flutter/material.dart';
import 'package:trump/components/index.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/util/util.dart';

class TripOrActivityItem extends StatelessWidget {
  final bool isActive;
  final Post post;
  const TripOrActivityItem({
    super.key,
    this.isActive = true,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.black;
    //todo: 行程结束时间到，则isActive变为false
    if (isActive == true) {
      textColor = Colors.white;
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Dot(
            radius: 8,
            color: isActive == true ? Colors.blue : Colors.grey.withAlpha(100),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color:
                    isActive == true ? Colors.blue : Colors.grey.withAlpha(100),
              ),
              child: DefaultTextStyle(
                style: TextStyle(color: textColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      absoluteTime(post.createTime),
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      post.title,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
