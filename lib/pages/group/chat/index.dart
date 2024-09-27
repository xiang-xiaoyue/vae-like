import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/models/resp/models/msg.dart';
import 'package:trump/pages/group/chat/vm.dart';
import 'package:trump/pages/mine/vm.dart';

// 群聊天界面
class GroupChatPage extends StatelessWidget {
  final String id;
  const GroupChatPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupChatViewModel>(
      create: (context) => GroupChatViewModel(id),
      child: Consumer<GroupChatViewModel>(builder: (context, vm, _) {
        return (vm.group == null)
            ? Scaffold()
            : PopScope(
                onPopInvoked: (didpop) {
                  if (didpop == true) {
                    vm.disposeChannel();
                  }
                },
                child: Scaffold(
                  backgroundColor: Colors.grey.shade200,
                  appBar: CommonAppBar(
                    title: vm.group!.name,
                    rightPadding: 0,
                    actions: [
                      IconButton(
                        onPressed: () {
                          context.pushNamed("group_detail",
                              pathParameters: {"id": vm.group!.id.toString()});
                        },
                        icon: Icon(
                          Icons.more_horiz,
                          size: 28,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),
                  body: const _Body(),
                ),
              );
      }),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({super.key});

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupChatViewModel>(builder: (context, vm, _) {
      return Stack(
        fit: StackFit.expand,
        children: [
          ListView.builder(
            controller: scrollController,
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 56),
            itemBuilder: (ctx, idx) {
              Msg m = vm.msgs[idx];
              if (DateTime.fromMillisecondsSinceEpoch(m.createTime)
                  //.add(Duration(days: 2))
                  .add(Duration(minutes: 45))
                  .isBefore(DateTime.now())) {
                return Column(
                  children: [
                    MsgTimeTip(),
                    MsgItem(msg: m),
                  ],
                );
              }
              // 退群或撤回消息
              //   // return GroupMemberActionTip()
              return MsgItem(msg: m);
            },
            itemCount: vm.msgs.length,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 54,
              padding: EdgeInsets.symmetric(horizontal: 8),
              color: Colors.grey.shade200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(width: 1, color: Colors.grey)),
                    width: 24,
                    height: 24,
                    child: const Icon(
                      Icons.mic_none,
                      size: 22,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 12),
                  _MsgInput(controller: controller),
                  const SizedBox(width: 8),
                  // const Icon(
                  //   Icons.sentiment_very_satisfied,
                  //   color: Colors.grey,
                  //   size: 28,
                  // ),
                  // const Icon(
                  //   Icons.add_circle_outline,
                  //   color: Colors.grey,
                  //   size: 28,
                  // ),
                  TrumpButton(
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    borderStyle: BorderStyle.none,
                    height: 32,
                    backgroundColor: Colors.blue.shade900,
                    text: "发送",
                    textSize: 12,
                    onTap: () {
                      vm.sendMsg(controller.text.trim());
                      controller.text = "";
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

class _MsgInput extends StatelessWidget {
  final TextEditingController controller;
  const _MsgInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        cursorHeight: 18,
        cursorColor: Colors.green,
        cursorWidth: 1,
        maxLines: 1,
        minLines: 1,
        decoration: InputDecoration(
          hintText: "当前只支持发送文字",
          isCollapsed: true,
          contentPadding: EdgeInsets.all(4),
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class GroupMemberActionTip extends StatelessWidget {
  final String username;
  final String text;
  const GroupMemberActionTip({
    super.key,
    required this.text,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Text.rich(
        TextSpan(
          text: "$username ",
          style: TextStyle(color: Colors.blue.shade800),
          children: [
            TextSpan(
              text: text,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MsgTimeTip extends StatelessWidget {
  const MsgTimeTip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        "昨天10:57",
        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
      ),
    );
  }
}

class MsgItem extends StatelessWidget {
  final Msg msg;
  const MsgItem({
    super.key,
    required this.msg,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentUserViewModel>(builder: (context, curUser, _) {
      return (curUser.user != null)
          ? Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Consumer<GroupChatViewModel>(builder: (context, vm, _) {
                return (vm.group != null && vm.group!.members!.isNotEmpty)
                    ? Row(
                        textDirection: curUser.user!.id == msg.fromUserId
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        children: [
                          UserAvatar(
                              url: vm.group!.members!
                                  .firstWhere((i) => i.id == msg.fromUserId)
                                  .avatarUrl,
                              size: 36,
                              radius: 4),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment:
                                curUser.user!.id == msg.fromUserId
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                            children: [
                              Text(
                                "  ${vm.group!.members!.firstWhere((i) => i.id == msg.fromUserId).name}  ",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: curUser.user!.id == msg.fromUserId
                                      ? Colors.blue
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  msg.content,
                                  style: TextStyle(
                                      color: curUser.user!.id == msg.fromUserId
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : SizedBox();
              }),
            )
          : SizedBox();
    });
  }
}
