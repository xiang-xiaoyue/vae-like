import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trump/models/resp/models/subject.dart';

class SearchPageSubjectItem extends StatelessWidget {
  final String text;
  final String id;
  const SearchPageSubjectItem({
    super.key,
    required this.text,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed("subject_detail", queryParameters: {"id": id});
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.withAlpha(300),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          "#$text",
          strutStyle: const StrutStyle(forceStrutHeight: true, leading: .5),
        ),
      ),
    );
  }
}

// 带有热度值的话题item
class SearchSubjectItemWithHotValue extends StatelessWidget {
  final Subject subject;
  const SearchSubjectItemWithHotValue({
    super.key,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.grey.withAlpha(100)),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          context.pushNamed("subject_detail",
              queryParameters: {"id": subject.id.toString()});
        },
        child: Row(
          children: [
            const Icon(Icons.numbers_sharp, size: 18, color: Colors.blue),
            Text(
              " ${subject.name}",
              style: const TextStyle(height: 1.4, fontSize: 18),
            ),
            const Spacer(),
            const Text(
              "1000点热度",
              style: TextStyle(color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}
