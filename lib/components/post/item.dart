// ignore_for_file: unused_element, must_be_immutable, prefer_const_constructors_in_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trump/models/resp/index.dart';

import '../exports.dart';

// post列表页面展示的条目，如果不是长文，就尽量展示，todo: 如果是长文，还没见过怎么展示的，暂时不管
class PostItem extends StatelessWidget {
  final Post post;
  PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed("post_detail",
            pathParameters: {"id": (post.id).toString()});
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 头像，名字，发布时间
            PostHeaderSection(post: post),
            //标题、音乐card、文字内容、图片
            if (post.title != '') PostTitleSection(title: post.title), //标题
            if (post.voiceUrl != '')
              PostVoicePlayerSection(
                url: post.voiceUrl,
                setDurationSeconds: () {},
                resetUrl: () {},
                showReRecord: false,
              ),
            if (post.musicUrl != '') const PostMusicSection(), // 音乐
            if (post.content != '') PostTextContentSection(post: post), //文字部分
            // 图片列表
            if (post.imageList.join('').isNotEmpty)
              PostImageListSection(post: post),
            //const SizedBox(height: 20),
            // 定位和话题标签
            PostLocationAndSubjectSection(post: post),
          ],
        ),
      ),
    );
  }
}

// 标题部分
// 草稿箱中未发布的postItem样式，分下、下两部分。
/*
class _DraftItemContainer extends StatelessWidget {}
*/
