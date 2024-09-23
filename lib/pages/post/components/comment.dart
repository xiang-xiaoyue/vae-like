// ignore_for_file: must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/avatar.dart';
import 'package:trump/components/hero_pic.dart';
import 'package:trump/components/icon_and_text.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/comment.dart';
import 'package:trump/pages/post/sub/comment_detail/vm.dart';
import 'package:trump/util/util.dart';

class CommentItem extends StatelessWidget {
  final Function? like;
  final Comment comment;
  bool isCommentDetailPage; // 是不是评论详情页面的详情项（即页面最顶上的那个评论）
  CommentItem({
    super.key,
    required this.comment,
    this.isCommentDetailPage = false,
    this.like,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatar(
            url: comment.user.avatarUrl,
            size: 40,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.1,
                    color: Colors.blueGrey,
                    style: isCommentDetailPage == true
                        ? BorderStyle.none
                        : BorderStyle.solid,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CommentItemHeader(comment: comment),

                  /// 头部：头像、名字、时间、楼层
                  _CommentItemMain(comment: comment), // 主体内容
                  _CommentItemFooter(
                    // 底部：定位、点赞、回复
                    isCommentDetailPage: isCommentDetailPage,
                    like: like,
                    comment: comment,
                  ),
                  // 展示相关post
                  isCommentDetailPage == true
                      ? _RelatedPostLink(post: comment.post)
                      : const SizedBox(),
                  // 展示父级评论
                  // isCommentDetailPage == false
                  //     ? const SizedBox()
                  //     : _CommentItemRepliedArea(parent: comment.parent),
                  _CommentItemRepliedArea(parent: comment.parent),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RelatedPostLink extends StatefulWidget {
  Post? post;
  _RelatedPostLink({
    this.post,
  });

  @override
  State<_RelatedPostLink> createState() => _RelatedPostLinkState();
}

class _RelatedPostLinkState extends State<_RelatedPostLink> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void toPostDetail(BuildContext context, int postId) {
      context
          .pushNamed("post_detail", pathParameters: {"id": postId.toString()});
    }

    return Consumer<CommentDetailViewModel>(builder: (context, vm, child) {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            height: 80,
            decoration: BoxDecoration(
              color: Colors.blueGrey.withAlpha(30),
            ),
            child: GestureDetector(
              onTap: () => toPostDetail(context, vm.comment!.postId),
              child: Row(
                children: [
                  Image.network(
                    width: 80,
                    height: 80,
                    widget.post?.user.avatarUrl ?? '',
                    fit: BoxFit.cover,
                    // loadingBuilder: (ctx, child, lp) {
                    //   return Text("loading...");
                    // },
                    errorBuilder: (ctx, err, st) {
                      return Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey.withAlpha(80),
                        child: Center(
                          child: Text("无"),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                  //Text(vm.relatedPost.title ?? vm.relatedPost.content),
                  Text(vm.comment?.post?.title ??
                      vm.comment?.post?.content ??
                      '无内容'),
                ],
              ),
            ),
          ),
          DefaultTextStyle(
            style: const TextStyle(color: Colors.blue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () => toPostDetail(context, vm.comment!.postId),
                    child: const Text("帖子")),
                GestureDetector(
                    onTap: () => toPostDetail(context, vm.comment!.postId),
                    child: const Text("查看详情")),
              ],
            ),
          ),
        ],
      );
    });
  }
}

// 评论底部：被回复次数与被点赞次数
class _CommentItemFooter extends StatelessWidget {
  final Function? like;
  final Comment comment;
  final bool isCommentDetailPage;
  const _CommentItemFooter({
    required this.comment,
    required this.isCommentDetailPage,
    this.like,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isCommentDetailPage == true
            ? const SizedBox()
            : IconAndText(
                isMarginLeft: false,
                icon: Icons.location_on,
                text: comment.locationName,
              ),
        const Spacer(),
        isCommentDetailPage == true
            ? SizedBox()
            : GestureDetector(
                onTap: () {
                  context.pushNamed("comment_detail",
                      pathParameters: {"id": comment.id.toString()});
                },
                child: IconAndText(
                  isMarginLeft: true,
                  icon: Icons.comment,
                  text: comment.childCount.toString(),
                  onTap: () {
                    //todo: 是否将对象传给另一页面更好？用extra还是什么?
                    context.pushNamed("create_comment", queryParameters: {
                      "post_id": comment.postId.toString(),
                      "top_id": (comment.topId > 0 ? comment.topId : comment.id)
                          .toString(),
                      "parent_id": comment.id.toString(),
                      "parent_content": comment.content,
                      "uname": comment.user.name,
                    });
                  },
                ),
              ),
        IconAndText(
          icon: Icons.thumb_up_outlined,
          text: comment.likeCount.toString(),
          iconColor: comment.isLiking == true ? Colors.red : null,
          textColor: comment.isLiking ? Colors.red : null,
          onTap: () {
            if (like != null) {
              like!();
            }
          },
        ),
      ],
    );
  }
}

class _CommentItemRepliedArea extends StatelessWidget {
  final Comment? parent;
  const _CommentItemRepliedArea({
    required this.parent,
  });

  @override
  Widget build(BuildContext context) {
    // 进入一个新页面查看图片详情
    void showPicDetail(String url) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return _PicDetailPage();
      }));
    }

    return parent == null
        ? const SizedBox()
        : Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.blueGrey.withAlpha(40),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CommentItemHeader(comment: parent!),
                const SizedBox(height: 4),
                Text.rich(
                  TextSpan(
                    text: parent?.content,
                    style: const TextStyle(fontSize: 16),
                    children: [
                      parent!.picUrl == ""
                          ? const TextSpan(text: "")
                          : TextSpan(
                              text: "  [查看图片]",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.pushNamed("pic_detail",
                                      queryParameters: {"url": parent!.picUrl});
                                },
                              style: TextStyle(color: Colors.blue),
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      "comment_detail",
                      pathParameters: {"id": (parent?.id).toString()},
                    );
                  },
                  child: Text(
                    "共${parent?.childCount}条回复",
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ),
              ],
            ),
          );
  }
}

// 评论主体:文本+图片
class _CommentItemMain extends StatelessWidget {
  final Comment comment;
  const _CommentItemMain({
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(comment.content),
        const SizedBox(height: 10),
        if (comment.picUrl == "")
          const SizedBox()
        else
          GestureDetector(
            onTap: () {
              context.pushNamed("pic_detail",
                  queryParameters: {"url": comment.picUrl});
            },
            child: HeroPic(picUrl: comment.picUrl, width: 120),
          ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _CommentItemHeader extends StatelessWidget {
  final Comment comment;
  const _CommentItemHeader({required this.comment});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.grey),
      child: Row(
        children: [
          Text(
            comment.user.name,
            style: const TextStyle(color: Colors.black54, fontSize: 15),
          ),
          const Spacer(),
          Text("${comment.floorNumber}楼"),
          SizedBox(width: 8),
          Text(relativeTime(comment.createTime)),
        ],
      ),
    );
  }
}

class _PicDetailPage extends StatelessWidget {
  const _PicDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
