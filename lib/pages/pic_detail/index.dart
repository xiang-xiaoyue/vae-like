import 'package:flutter/material.dart';
import 'package:trump/components/hero_pic.dart';

// 点击图片后，查看图片详情
class PicDetailPage extends StatelessWidget {
  final String url;
  const PicDetailPage({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    double width = 300;
    MediaQuery.sizeOf(context).width;
    return HeroPic(picUrl: url, width: width, isFitWidth: true);
  }
}
