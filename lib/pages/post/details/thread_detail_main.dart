// 帖子详情页面信息
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/models/post.dart';
import 'package:trump/components/exports.dart';
import 'package:trump/pages/post/vm.dart';

class ThreadDetailItem extends StatelessWidget {
  final Post post;
  const ThreadDetailItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      color: Colors.white,
      child: Column(
        children: [
          PostHeaderSection(post: post),
          //标题、音乐card、文字内容、图片
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostTitleSection(title: post.title), //标题
              if (post.voiceUrl != '')
                PostVoicePlayerSection(
                  url: post.voiceUrl,
                  setDurationSeconds: () {},
                  resetUrl: () {},
                  showReRecord: false,
                ),
              if (post.musicUrl != '') const PostMusicSection(), // 音乐
              PostTextContentSection(post: post), //文字部分
              if (post.videoUrl != '') PostVideoSection(url: post.videoUrl),
              // 投票部分
              if (post.subType == Constants.postSubTypeVote &&
                  post.voteResult != null)
                Consumer<PostDetailViewModel>(builder: (context, vm, _) {
                  return PostVoteSection(
                    list: post.voteResult!,
                    endTime: post.endTime,
                    vote: (i) => vm.vote(i),
                  );
                }),
              // 图片列表
              if (post.imageList.join('').isNotEmpty)
                PostImageListSection(post: post)
            ],
          ),
        ],
      ),
    );
  }
}
