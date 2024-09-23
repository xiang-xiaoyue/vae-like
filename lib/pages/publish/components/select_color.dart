import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/pages/publish/sub/post/vm.dart';
import 'package:trump/util/color.dart';

class PublishPostSelectColor extends StatelessWidget {
  const PublishPostSelectColor({super.key, required this.colors});

  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: colors.map((item) {
          return Consumer<CreatePostViewModel>(builder: (context, vm, child) {
            return GestureDetector(
              onTap: () => vm.setSelectedColor(item),
              child: WordsBackgroundColorItem(color: item),
            );
          });
        }).toList(),
      ),
    );
  }
}

class WordsBackgroundColorItem extends StatelessWidget {
  final Color color;
  const WordsBackgroundColorItem({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
    );
  }
}
