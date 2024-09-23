import 'package:flutter/material.dart';

class TrumpButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final BorderStyle borderStyle;
  final double borderRadius;
  final String text;
  final Function? onTap;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  double? width;
  double? height;
  double textSize;
  FontWeight fontWeight;

  TrumpButton({
    super.key,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.grey,
    this.borderStyle = BorderStyle.solid,
    this.borderRadius = 8,
    this.text = "",
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.textSize = 14,
    this.fontWeight = FontWeight.w400,
    this.onTap,
    this.borderColor = Colors.grey,

    ///}) : borderColor =Colors.grey.withOpacity(0.5);
  });

  @override
  Widget build(BuildContext context) {
    if ((width != null && width! > 0) || (height != null && height! > 0)) {
      padding = padding ?? const EdgeInsets.all(0);
    }
    return GestureDetector(
      onTap: () => onTap != null ? onTap!() : null,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
        margin: margin ?? const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            width: 1,
            color: borderColor,
            style: borderStyle,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: textSize, color: textColor),
          ),
        ),
      ),
    );
  }
}
