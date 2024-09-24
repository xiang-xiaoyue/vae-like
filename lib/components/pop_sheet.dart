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
  final BorderRadius? borderRadius;
  final bool showBottomBorder;
  final TextStyle textStyle;
  const SheetActionItem({
    super.key,
    this.text = "取消",
    this.onTap,
    this.borderRadius,
    this.showBottomBorder = true,
    this.textStyle = const TextStyle(color: Colors.blue, fontSize: 18),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 46,
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
          border: Border(
            bottom: BorderSide(
                width: showBottomBorder == true ? 1 : 0,
                color: Colors.grey.shade200),
          ),
        ),
        child: Text(text, style: textStyle),
      ),
    );
  }
}
