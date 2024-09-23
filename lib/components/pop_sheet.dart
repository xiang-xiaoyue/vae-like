import 'package:flutter/material.dart';

class PopActionSheet extends StatelessWidget {
  final List<SheetActionItem> list;
  const PopActionSheet({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          context: context,
          builder: (context) {
            //note: return BottomSheet()不好设置自适应高度;
            return SingleChildScrollView(
              child: Column(children: list),
            );
          },
        );
      },
      child: const Icon(
        Icons.more_horiz,
        color: Colors.grey,
      ),
    );
  }
}

class SheetActionItem extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const SheetActionItem({
    super.key,
    this.text = "取消",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        margin: const EdgeInsets.only(bottom: 4, left: 8, right: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(text),
      ),
    );
  }
}
