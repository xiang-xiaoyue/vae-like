import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/pages/mine/vm.dart';
import 'package:trump/pages/notice/export.dart';
import 'package:trump/pages/publish/sub/draft/vm.dart';
import 'package:trump/util/util.dart';

// 草稿箱，todo: 都是post,但是应该也可以有subject才对
class DraftPage extends StatelessWidget {
  const DraftPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DraftViewModel>(
      create: (context) => DraftViewModel(),
      child: Consumer<DraftViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            appBar: CommonAppBar(
              title: "草稿箱",
              rightPadding: 0,
              actions: [
                if (vm.isEditing == true)
                  TextButton(
                    onPressed: () => vm.toggleEditing(),
                    child: const Text(
                      "完成",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                else
                  TextButton(
                    onPressed: () => vm.toggleEditing(),
                    child: const Text(
                      "编辑",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
              ],
            ),
            body: ListView.builder(
              itemBuilder: (context, index) {
                if (index == vm.posts.length) {
                  return NoMore();
                }
                return NewWidget(post: vm.posts[index]);
              },
              itemCount: vm.posts.length + 1,
            ),
          );
        },
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  final Post post;

  const NewWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentUserViewModel>(builder: (context, cur, _) {
      return GestureDetector(
        onTap: () {
          cur.saveCurrentEdittingThread(post).then((_) {
            context.pushReplacementNamed("publish", queryParameters: {
              "id": post.id.toString(),
              "type": post.subType
            });
          });
        },
        child: Container(
          margin: EdgeInsets.only(top: 4),
          color: Colors.white,
          child: Column(
            //todo: 长文，现在只能放图片（最多20张）、音乐（不是录音）、文字
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                // todo: 草稿时间和发布时间都用create_time,到底合适吗？
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("草稿时间: ${absoluteTime(post.createTime)}"),
                    Consumer<DraftViewModel>(builder: (context, vm, _) {
                      return vm.isEditing == true
                          ? GestureDetector(
                              onTap: () {
                                vm.removePost(post);
                              },
                              child: Text(
                                "删除",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          : SizedBox();
                    }),
                  ],
                ),
              ),
              Divider(
                height: 0.2,
                color: Colors.grey.shade100,
              ),
              // 长文的标题或其他类型帖子的内容节选
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  (post.subType == Constants.postSubTypeLongText)
                      ? post.title
                      : post.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              // 录音部分
              if (post.voiceUrl.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: PostVoicePlayerSection(
                      url: post.voiceUrl,
                      setDurationSeconds: () {},
                      resetUrl: () {}),
                ),
              // 音乐部分
              if (post.musicUrl.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: PostMusicSection(),
                ),
              // 长文内容节选
              if (post.subType == Constants.postSubTypeLongText)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    post.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              // 图片列表（共9张)
              if (post.imageList.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: PostImageListSection(post: post),
                ),
              //todo: 长文章的图片与文字互相穿插，但在草稿箱界面，只显示第一段文字。而且最多显示两行
              // longTextSection
            ],
          ),
        ),
      );
    });
  }
}
