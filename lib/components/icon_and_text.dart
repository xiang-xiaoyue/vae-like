import 'package:flutter/material.dart';

class IconAndText extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isMarginLeft;
  Color? iconColor;
  Color? textColor;
  Function? onTap;
  IconAndText({
    super.key,
    required this.icon,
    required this.text,
    this.isMarginLeft = true,
    this.iconColor,
    this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null ? () => onTap!() : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        margin: isMarginLeft
            ? const EdgeInsets.only(left: 8)
            : const EdgeInsets.only(right: 8),
        child: Row(
          children: [
            Icon(icon, size: 16, color: iconColor ?? Colors.blueGrey),
            const SizedBox(width: 4),
            Text(
              text,
              // note:对齐数字与icon
              strutStyle:
                  const StrutStyle(forceStrutHeight: true, leading: 0.1),
              style:
                  TextStyle(fontSize: 16, color: textColor ?? Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}
