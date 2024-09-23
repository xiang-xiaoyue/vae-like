import 'package:flutter/material.dart';
import 'package:trump/models/resp/models/post.dart';
import 'package:trump/components/exports.dart';
import 'package:trump/util/util.dart';

// 官方动态详情
class TrendDetailItem extends StatelessWidget {
  final Post post;
  const TrendDetailItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostTitleSection(title: post.title), //标题
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: null,
                child: const Text("#杭州站",
                    style: TextStyle(color: Colors.blue, fontSize: 12)),
              ),
              const SizedBox(width: 12),
              Text(
                absoluteTime(post.createTime, requireYear: false),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostTextContentSection(post: post), //文字部分
              const SizedBox(height: 8),
              // 视频部分
              post.videoUrl != ""
                  ? PostVideoSection(url: post.videoUrl)
                  : const SizedBox(),
              // 图片部分
              GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  //_TmpImage(index: 5),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
