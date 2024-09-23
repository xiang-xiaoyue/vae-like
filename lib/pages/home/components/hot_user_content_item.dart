import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trump/components/avatar.dart';
import 'package:trump/components/index.dart';
import 'package:trump/models/resp/models/content.dart';
import 'package:trump/util/util.dart';

// 指定角色发布的内容item
class HotUserContentItem extends StatelessWidget {
  final Content content;
  final bool isLast;
  const HotUserContentItem(
      {super.key, required this.content, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 如果是帖子就跳转到帖子详情
        // 如果是评论就跳转到评论详情页面
        if (content.type == "thread") {
          context.pushNamed("post_detail",
              pathParameters: {"id": content.id.toString()});
        } else if (content.type == "comment") {
          context.pushNamed("comment_detail",
              pathParameters: {"id": content.id.toString()});
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isLast ? const Color(0xfff0faf9) : const Color(0xfff2f6ff),
          borderRadius: BorderRadius.circular(8),
        ),
        child: _Item(content: content, isLast: isLast),
      ),
    );
  }
}

// 有一张封面
class _Item extends StatelessWidget {
  final bool isLast;
  final Content content;
  const _Item({required this.content, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        content.picUrl.isNotEmpty
            ? Row(
                children: [
                  UserAvatar(
                      url: content.picUrl,
                      size: 100,
                      hintText: content.user.name[0]),
                  const SizedBox(width: 16),
                ],
              )
            : const SizedBox(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  UserAvatar(url: content.user.avatarUrl, radius: 4, size: 32),
                  const SizedBox(width: 8),
                  Text(content.user.name),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                content.title,
                style: const TextStyle(fontSize: 16),
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Spacer(),
                  Text(
                    absoluteTime(content.createTime),
                    style: TextStyle(
                        color: isLast
                            ? const Color(0xffbad8d3)
                            : const Color(0xffbcc9f1)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
