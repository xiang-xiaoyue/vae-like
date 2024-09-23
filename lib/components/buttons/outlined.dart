import 'package:flutter/material.dart';

class TrumpOutlinedButton extends StatelessWidget {
  final String text;
  final Function? onTap;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;

  const TrumpOutlinedButton({
    super.key,
    required this.text,
    this.onTap,
    this.borderColor = Colors.grey,
    this.backgroundColor = Colors.transparent,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 0.5, color: borderColor),
          color: backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4,
          ),
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
