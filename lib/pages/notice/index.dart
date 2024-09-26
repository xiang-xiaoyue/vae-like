import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/models/group.dart';
import 'package:trump/pages/notice/vm.dart';
import 'package:trump/util/util.dart';

// 消息通知页面
class NoticeIndexPage extends StatelessWidget {
  const NoticeIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Consumer<NoticeIndexViewModel>(
          builder: (context, vm, child) {
            return Column(
              children: [
                if (child != null) child,
                _NoticeMenuItem(
                    pathName: "official_notice",
                    text: "官方消息",
                    type: Constants.noticeTypeOfficial,
                    count: vm.officialUnreadCount),
                _NoticeMenuItem(
                    pathName: "at_me_notice",
                    type: Constants.noticeTypeAt,
                    text: "@我的",
                    count: vm.atUnreadCount),
                _NoticeMenuItem(
                    pathName: "comment_notice",
                    text: "评论",
                    type: Constants.noticeTypeComment,
                    count: vm.commentUnreadCount),
                _NoticeMenuItem(
                    pathName: "like_notice",
                    text: "赞",
                    type: Constants.noticeTypeLike,
                    count: vm.likeUnreadCount),
              ],
            );
          },
          child: AppBar(
            title: const Text("消息"),
            automaticallyImplyLeading: false,
            centerTitle: true,
            actions: [
              GestureDetector(
                child: const Text("联系人"),
                onTap: () {
                  context.pushNamed("contacts");
                },
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _NoticeMenuItem extends StatelessWidget {
  final String text;
  final int count;
  final String pathName;
  final String type;
  const _NoticeMenuItem({
    required this.text,
    this.count = 0,
    required this.pathName,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NoticeIndexViewModel>(builder: (context, vm, child) {
      return GestureDetector(
        onTap: () {
          if (pathName != "official_notice" &&
              pathName != "at_me_notice" &&
              pathName != "comment_notice" &&
              pathName != "like_notice" &&
              pathName != 'group_chat') {
            _showNoPath(context);
            return;
          } else {
            context.pushNamed(pathName).then((_) {
              vm.readNotice(type, 0);
            });
            return;
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Badge(
                backgroundColor: Colors.redAccent,
                smallSize: 8,
                isLabelVisible: count <= 0 ? false : true,
                label: Text("$count"),
                child: Container(
                  alignment: Alignment.center,
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withAlpha(80),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.home, color: Colors.blue, size: 30),
                ),
              ),
              const SizedBox(width: 8),
              Text(text),
              const Spacer(),
              const Icon(Icons.arrow_right_alt, color: Colors.grey),
            ],
          ),
        ),
      );
    });
  }

  Future<dynamic> _showNoPath(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              width: 200,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                "不存在此路径",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          );
        });
  }
}

class _NoticeGroupChatMenuItem extends StatelessWidget {
  final Group group;
  const _NoticeGroupChatMenuItem({
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed("group_chat",
            pathParameters: {"id": group.id.toString()});
        return;
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Badge(
              backgroundColor: Colors.redAccent,
              smallSize: group.id <= 0 ? 0 : 10,
              isLabelVisible: false,
              label: group.id <= 0 ? null : Text("${group.id}"),
              child: Container(
                alignment: Alignment.center,
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withAlpha(80),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.home, color: Colors.blue, size: 30),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                Text(group.name),
                Text(
                  group.brief,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ],
            ),
            const Spacer(),
            Text(relativeTime(group.createTime)),
          ],
        ),
      ),
    );
  }
}
