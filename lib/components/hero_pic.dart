import 'package:flutter/material.dart';

class HeroPic extends StatelessWidget {
  const HeroPic({
    super.key,
    required this.picUrl,
    required this.width,
    this.isFitWidth = false,
  });

  final String picUrl;
  final double width;
  final bool isFitWidth;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: picUrl,
      child: Image.network(
        picUrl,
        errorBuilder: (ctx, e, st) {
          return const SizedBox(
            child: Text("图片加载失败"),
          );
        },
        width: width,
        height: width,
        fit: isFitWidth == true ? BoxFit.fitWidth : BoxFit.cover,
      ),
    );
  }
}
