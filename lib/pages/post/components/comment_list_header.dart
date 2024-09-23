import 'package:flutter/material.dart';

class CommentListHeader extends StatelessWidget {
  final int count;
  const CommentListHeader({super.key, this.count = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 4),
      color: Colors.white,
      child: Row(
        children: [
          Text("全部评论($count)"),
          const Spacer(),
          //const Text("时间正序"),
          const SizedBox(
            height: 15,
            child: VerticalDivider(
              thickness: 1,
              color: Colors.grey,
              width: 16,
            ),
          ),
          const Text("时间倒序"),
        ],
      ),
    );
  }
}
