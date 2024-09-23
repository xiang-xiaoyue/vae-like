import 'package:flutter/material.dart';
import 'package:trump/models/resp/models/subject.dart';

class SubjectSampleItem extends StatelessWidget {
  final Subject subject;
  const SubjectSampleItem({
    super.key,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.numbers_sharp,
          size: 18,
          color: Colors.blue,
        ),
        Text(
          subject.name,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
