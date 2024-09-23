import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:trump/components/hero_pic.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:trump/components/avatar.dart';
import 'package:trump/components/icon_and_text.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/models/post.dart';
import 'package:trump/models/resp/models/vote_result_item.dart';
import 'package:trump/pages/publish/components/pic_item.dart';
import 'package:trump/util/util.dart';

// post详情页面 顶部的用户信息和发布时间
class PostHeaderSection extends StatelessWidget {
  const PostHeaderSection({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UserAvatar(url: post.user.avatarUrl, hintText: post.user.name[0]),
        const SizedBox(width: 10),
        Text(post.user.name), //todo:后面还有数字，有的是图标，不知道是什么意思
        const Spacer(),
        Text(relativeTime(post.createTime)),
      ],
    );
  }
}

class PostVideoSection extends StatefulWidget {
  final String url;
  const PostVideoSection({
    super.key,
    required this.url,
  });

  @override
  State<PostVideoSection> createState() => _PostVideoSectionState();
}

class _PostVideoSectionState extends State<PostVideoSection> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.networkUrl(Uri.parse(widget.url)),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlickVideoPlayer(flickManager: flickManager);
  }
}

class PostTitleSection extends StatelessWidget {
  final String title;
  const PostTitleSection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: title == ""
          ? const SizedBox()
          : Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
    );
  }
}

// 文字部分
class PostTextContentSection extends StatelessWidget {
  int getColor(String c) {
    if (c == "") {
      return Colors.white.value;
    }
    return int.parse(c.substring(2, 10), radix: 16);
  }

  final Post post;
  const PostTextContentSection({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: post.subType == Constants.postSubTypeShortText
            ? Color(getColor(post.color))
            : Colors.white,
        borderRadius: BorderRadius.circular(8),
        //color: Colors.blue.shade300,
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: post.color.isNotEmpty
          ? const EdgeInsets.all(8)
          : const EdgeInsets.all(0),
      child: Text(
        post.content,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

// 音乐部分
class PostMusicSection extends StatelessWidget {
  const PostMusicSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.pink.withAlpha(80),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                "assets/images/1.jpg",
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "音乐标题",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Text(
                "音乐专辑作者",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Center(
            child: Column(
              children: [
                Text(""),
                Icon(Icons.play_circle_outline, color: Colors.white),
                Text(""),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 图片列表部分
class PostImageListSection extends StatelessWidget {
  const PostImageListSection({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: post.imageList.map((i) {
          //return PublishDisplayPicItem(url: i, showClose: false);
          return GestureDetector(
              onTap: () =>
                  context.pushNamed("pic_detail", queryParameters: {"url": i}),
              child: HeroPic(picUrl: i, width: 300));
        }).toList(),
      ),
    );
  }
}

class PostVoteSection extends StatelessWidget {
  final List<VoteResultItem> list;
  final int endTime;
  final Function vote;
  const PostVoteSection({
    super.key,
    required this.list,
    required this.endTime,
    required this.vote,
  });

  @override
  Widget build(BuildContext context) {
    bool expired =
        DateTime.fromMillisecondsSinceEpoch(endTime).isBefore(DateTime.now());
    int total = 0;
    for (var i in list) {
      total += i.voteCount;
    }
    return Column(
      children: [
        ...list.map((item) =>
            VoteOptionItem(item: item, total: total, vote: (i) => vote(i))),
        const SizedBox(height: 8),
        DefaultTextStyle(
          style: const TextStyle(color: Colors.grey, fontSize: 12),
          child: Row(
            children: [
              Text("投票结束时间：${absoluteTime(endTime)}"),
              const Spacer(),
              expired
                  ? const Text("投票已结束")
                  : const Text(
                      "投票进行中",
                      style: TextStyle(color: Colors.blue),
                    ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _VideoCoverInfo extends StatelessWidget {
  const _VideoCoverInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.red,
        image: DecorationImage(
          image: AssetImage("assets/images/1.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        color: Colors.black12,
        child: const Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: Icon(
                  Icons.play_circle_fill,
                  color: Colors.white,
                  size: 45,
                ),
              ),
            ),
            DefaultTextStyle(
              style: TextStyle(color: Colors.white, fontSize: 14),
              child: Column(
                children: [
                  Spacer(),
                  Icon(Icons.play_arrow),
                  Row(
                    children: [
                      Text("1.3万播放"),
                      Text("8月13日"),
                      Spacer(),
                      Text("02:12"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 底部的定位与话题
class PostLocationAndSubjectSection extends StatelessWidget {
  const PostLocationAndSubjectSection({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const _TabItem(
          text: "中国",
          icon: Icons.location_on_outlined,
        ),
        _TabItem(text: post.subject.name),
        const Spacer(),
        IconAndText(
          icon: Icons.comment,
          text: post.commentCount.toString(),
        ),
        IconAndText(
          icon: Icons.thumb_up,
          text: post.likeCount.toString(),
        ),
      ],
    );
  }
}

// post底部定位和话题
class _TabItem extends StatelessWidget {
  final String text;
  final IconData icon;
  const _TabItem({
    required this.text,
    this.icon = Icons.numbers_sharp,
  });

  @override
  Widget build(BuildContext context) {
    return text == ""
        ? const SizedBox()
        : Container(
            margin: const EdgeInsets.only(right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: 16, color: Colors.blue),
                Text(
                  text,
                  style: const TextStyle(color: Colors.blue, height: 1),
                ),
              ],
            ),
          );
  }
}

class VoteOptionItem extends StatelessWidget {
  final VoteResultItem item;
  final int total;
  final Function vote;
  const VoteOptionItem({
    super.key,
    required this.item,
    required this.total,
    required this.vote,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => vote(item.voteOptionId),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: item.isVoted ? Colors.green.shade200 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${item.order}. ${item.content}"),
            Row(
              children: [
                SizedBox(
                  height: 6,
                  width: MediaQuery.of(context).size.width * 0.57,
                  child: LinearProgressIndicator(
                    value: total > 0 ? item.voteCount * 100 ~/ total / 100 : 0,
                    color: Colors.blueAccent,
                    backgroundColor: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const Spacer(),
                Text(
                    "${item.voteCount}票 ${(total > 0 ? item.voteCount * 100 ~/ total : 0)}%"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 播放录音
class PostVoicePlayerSection extends StatefulWidget {
  final String url;
  final Function setDurationSeconds;
  final Function resetUrl;
  final bool showReRecord;
  const PostVoicePlayerSection({
    super.key,
    required this.url,
    required this.setDurationSeconds,
    required this.resetUrl,
    this.showReRecord = true,
  });

  @override
  State<PostVoicePlayerSection> createState() => _PostVoicePlayerSectionState();
}

class _PostVoicePlayerSectionState extends State<PostVoicePlayerSection> {
  final AudioPlayer audioPlayer = AudioPlayer();
  int durationSeconds = 1;
  bool isPlaying = false;

  void newMethod() async {
    if (isPlaying) {
      await audioPlayer.stop();
      isPlaying = false;
      setState(() {});
    } else {
      isPlaying = true;
      audioPlayer.setUrl(widget.url);
      await audioPlayer.play();
      setState(() {});
      //widget.setDurationSeconds(durationSeconds);
      // if (audioPlayer.duration == null) {
      //   vm.setVoicePositionSeconds(0);
      // } else {
      //   int duration = audioPlayer.duration!.inSeconds;
      //   vm.setVoicePositionSeconds(duration);
      // }
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      audioPlayer.setUrl(widget.url).then((_) {
        durationSeconds = audioPlayer.duration?.inSeconds ?? 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: newMethod,
            child: getIcon(),
          ),
          const SizedBox(width: 4),
          Text("总时长：$durationSeconds秒"),
          const Spacer(),
          widget.showReRecord
              ? GestureDetector(
                  onTap: () => widget.resetUrl(""),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.refresh,
                        size: 28,
                        color: Colors.blue,
                      ),
                      Text(
                        "重录",
                        style: TextStyle(
                            fontSize: 12, color: Colors.blue.shade600),
                      )
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Icon getIcon() {
    return Icon(
      isPlaying == true ? Icons.stop : Icons.play_circle,
      color: isPlaying == true ? Colors.red : Colors.blue.shade800,
      size: 52,
    );
  }
}
