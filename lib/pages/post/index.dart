// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/app_bar.dart';
import 'package:trump/components/pop_sheet.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/pages/mine/vm.dart';
import 'package:trump/pages/notice/export.dart';
import 'package:trump/pages/post/components/comment.dart';
import 'package:trump/pages/post/components/comment_list_header.dart';
import 'package:trump/pages/post/vm.dart';

import 'details/thread_detail_main.dart';
import 'details/trend_detail_main.dart';

// post详情页面
class PostDetailPage extends StatelessWidget {
  final String id;
  const PostDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    Map<String, String> appBarTitleMap = {
      Constants.postTypeTrends: "",
      Constants.postTypeTrip: "行程",
      Constants.postTypeActivity: "活动",
      Constants.postTypeThread: "帖子",
      Constants.postTypeGoods: "商品",
    };
    return ChangeNotifierProvider<PostDetailViewModel>(
      create: (context) => PostDetailViewModel(id: id),
      child: Consumer<PostDetailViewModel>(builder: (context, vm, child) {
        return Consumer<CurrentUserViewModel>(builder: (context, curUser, _) {
          return Scaffold(
            appBar: CommonAppBar(
              title: appBarTitleMap[vm.post?.type] ?? '',
              actions: [
                if (vm.post?.type == Constants.postTypeThread)
                  PopActionSheet(
                    list: [
                      if ((curUser.user?.roles ?? []).contains("admin"))
                        const SheetActionItem(text: "设置为精华帖"),
                      const SheetActionItem(text: "举报"),
                      const SheetActionItem(text: "取消")
                    ],
                  )
              ],
            ),
            body: ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: vm.post == null
                        ? const SizedBox()
                        : _MainSection(post: vm.post!),
                  ),
                  if (curUser.isLoggedIn)
                    const PostDetailFooterToolBar(), // 转发，收藏，评论，点赞
                ],
              ),
            ),
          );
        });
      }),
    );
  }
}

// post详情页面内容主体
class _MainSection extends StatelessWidget {
  final Post post;
  const _MainSection({required this.post});

  @override
  Widget build(BuildContext context) {
    Widget getMain(String type) {
      switch (type) {
        case Constants.postTypeThread: // 用户帖子
          return ThreadDetailItem(post: post);
        case Constants.postTypeTrends: // 官方动态
          return TrendDetailItem(post: post);
        // todo:活动、行程
        case Constants.postTypeGoods:
          context.pushReplacementNamed("goods_detail",
              queryParameters: {"id": post.id.toString()});
          return SizedBox();
        default:
          return ThreadDetailItem(post: post); // 默认以帖子的样式展示
      }
    }

    return Column(
      children: [
        getMain(post.type),
        CommentListHeader(count: post.commentCount),
        const _CommentList(), //评论列表
      ],
    );
  }
}

class _CommentList extends StatelessWidget {
  const _CommentList();

  @override
  Widget build(BuildContext context) {
    return Consumer<PostDetailViewModel>(
      builder: (context, vm, child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 60),
          itemCount: vm.commentCount + 1,
          itemBuilder: (context, index) {
            if (index == vm.commentCount) {
              return const NoMore();
            }
            return CommentItem(
              comment: vm.comments[index],
              like: () {
                vm.toggleLikeComment(vm.comments[index]);
              },
            );
          },
        );
      },
    );
  }
}

// 底部的“转发”、“收藏”、“评论”和“点赞”.
class PostDetailFooterToolBar extends StatelessWidget {
  const PostDetailFooterToolBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 0.2, color: Colors.blueGrey),
          ),
        ),
        height: 60,
        child: Consumer<PostDetailViewModel>(builder: (context, vm, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.reply_outlined, color: Colors.black)),
              IconButton(
                onPressed: () => vm.toggleCollection(),
                icon: (vm.post?.isCollecting ?? false) == true
                    ? const Icon(Icons.star, color: Colors.red)
                    : const Icon(Icons.star_outline, color: Colors.black),
              ),
              IconButton(
                  // 评论post
                  onPressed: () => context.pushReplacementNamed(
                          "create_comment",
                          queryParameters: {
                            "post_id": vm.post!.id.toString(),
                            "top_id": "0",
                            "parent_id": "0",
                            "parent_content": '',
                          }),
                  icon:
                      const Icon(Icons.comment_outlined, color: Colors.black)),
              IconButton(
                  // 点赞post
                  onPressed: () => vm.toggleLikePost(),
                  icon: (vm.post?.isLiking ?? false) == true
                      ? const Icon(Icons.thumb_up, color: Colors.red)
                      : const Icon(Icons.thumb_up_outlined,
                          color: Colors.black)),
            ],
          );
        }),
      ),
    );
  }
}

// 帖子、投票的详情页面主体
// class _ThreadMainSection extends StatelessWidget {
//   const _ThreadMainSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
//
// // 官方动态详情页面主体
// class _TrendMainSection extends StatelessWidget {
//   const _TrendMainSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
// todo: 活动、行程详情页面主体
