import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trump/components/avatar.dart';
import 'package:trump/models/resp/models/notice.dart';
import 'package:trump/util/util.dart';

// 用户相关操作的通知消息样式,如：点赞、评论、@.
class NoticeItem extends StatelessWidget {
  const NoticeItem({
    super.key,
    required this.notice,
    this.callback,
  });

  final Notice notice;
  final Function? callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 4),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatar(
            url: notice.userAvatar,
            size: 28,
            radius: 4,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NameAndTime(time: notice.createTime, name: notice.username),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(notice.content),
                ),
                _MainContentCard(notice: notice),
                _ToPostDetailPage(notice: notice, callback: callback),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ToPostDetailPage extends StatelessWidget {
  const _ToPostDetailPage({
    super.key,
    required this.notice,
    this.callback,
  });

  final Notice notice;
  final Function? callback;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          context.pushNamed("post_detail",
              pathParameters: {"id": notice.postId.toString()}).then((_) {
            if (callback != null) {
              callback!();
            }
          });
        },
        child: Text(
          "查看原文",
          style: TextStyle(color: Colors.blue.shade800, fontSize: 12),
        ),
      ),
    );
  }
}

class _MainContentCard extends StatelessWidget {
  const _MainContentCard({
    super.key,
    required this.notice,
  });

  final Notice notice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 8,
        bottom: 8,
        right: 8,
        left: notice.objectType == "comment" ? 8 : 0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius:
            BorderRadius.circular(notice.objectType == "comment" ? 8 : 0),
      ),
      child: (notice.objectType == "comment")
          ? _CommentItem(notice: notice)
          : _PostItem(notice: notice),
    );
  }
}

// “我赞的”，“我评论”，“赞我的”，“评论我的”的那里被赞对象(评论)的信息
class _CommentItem extends StatefulWidget {
  const _CommentItem({
    super.key,
    required this.notice,
  });

  final Notice notice;

  @override
  State<_CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<_CommentItem> {
  late TapGestureRecognizer _recognizer;
  @override
  void initState() {
    super.initState();
    _recognizer = TapGestureRecognizer()..onTap = _viewImage;
  }

  @override
  void dispose() {
    _recognizer.dispose();
    super.dispose();
  }

  void _viewImage() {
    print("todo: 查看图片");
  }

//todo: 评论有“查看图片”功能,还有更多回复
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NameAndTime(
            time: widget.notice.objectCreateTime,
            name: widget.notice.ojbectDisplayName,
            floor: widget.notice.ojbectFloor),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text.rich(
            TextSpan(
              text: "${widget.notice.objectContent}  ",
              children: [
                widget.notice.objectImageUrl != ""
                    ? TextSpan(
                        text: "[查看图片]",
                        style: const TextStyle(color: Colors.blue),
                        recognizer: _recognizer)
                    : TextSpan(),
              ],
            ),
          ),
        ),
        widget.notice.objectReplyCount > 0
            ? GestureDetector(
                onTap: () => context.pushNamed("comment_detail",
                    pathParameters: {"id": widget.notice.objectId.toString()}),
                child: Text(
                  "查看更多回复(${widget.notice.objectReplyCount})",
                  style: const TextStyle(fontSize: 12, color: Colors.blue),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

// “我赞的”，“我评论”,“赞我的”，“评论我的”的那里被赞对象(post)的信息
class _PostItem extends StatelessWidget {
  const _PostItem({
    super.key,
    required this.notice,
  });
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserAvatar(
          url: notice.objectImageUrl,
          size: 64,
          radius: 0,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NameAndTime(
                  name: notice.ojbectDisplayName,
                  time: notice.objectCreateTime),
              Text(
                notice.objectContent,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// 传入名字、时间和可选的楼层数
class NameAndTime extends StatelessWidget {
  const NameAndTime({
    super.key,
    required this.time,
    required this.name,
    this.floor = 0,
  });

  final int time;
  final int floor;
  final String name;

  @override
  Widget build(BuildContext context) {
    var lightGreyStyle = TextStyle(
      color: Colors.grey.shade600,
      fontSize: 12,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: lightGreyStyle),
        Text(
            "${floor > 0 ? '$floor楼 ' : ''} ${absoluteTime(time, onlyDate: true)}",
            style: lightGreyStyle),
      ],
    );
  }
}
