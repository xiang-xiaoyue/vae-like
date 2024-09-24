// 发布页面

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/pages/mine/vm.dart';
import 'package:trump/pages/publish/components/select_color.dart';
import 'package:trump/pages/publish/sub/post/conponents/footer.dart';
import 'package:trump/pages/publish/sub/post/main_sections/pic_text.dart';
import 'package:trump/pages/publish/sub/post/main_sections/pure_text.dart';
import 'package:trump/pages/publish/sub/post/main_sections/video.dart';
import 'package:trump/pages/publish/sub/post/main_sections/voice.dart';
import 'package:trump/pages/publish/sub/post/main_sections/vote.dart';
import 'package:trump/pages/publish/sub/post/vm.dart';

class PublishPage extends StatefulWidget {
  //todo: 这里type是post的subType,简写成type容易引起误会。
  final String type;
  final String id;
  const PublishPage({super.key, required this.type, this.id = '0'});

  @override
  State<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  String selectedColor = '0xffffffff';

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Colors.grey.shade300,
      Colors.teal.shade200,
      Colors.blue.shade200,
      Colors.orange.shade200,
    ];
    return Consumer<CurrentUserViewModel>(builder: (context, cur, _) {
      return ChangeNotifierProvider<CreatePostViewModel>(
        create: (context) =>
            CreatePostViewModel(widget.type, cur.currentEdittingThread),
        child: Consumer<CreatePostViewModel>(builder: (context, vm, child) {
          var appBar = CommonAppBar(
            title: "",
            rightPadding: 0,
            actions: [
              Consumer<CurrentUserViewModel>(builder: (context, curUser, _) {
                return TextButton(
                  onPressed: () async {
                    await cur.saveCurrentEdittingThread(null);
                    vm.publish(status: "draft").then((pid) {
                      context.pushReplacementNamed("draft");
                    });
                  },
                  child: Text(
                    "存草稿",
                    style: TextStyle(color: Colors.blue),
                  ),
                );
              }),
              Consumer<CurrentUserViewModel>(builder: (context, curUser, _) {
                return TextButton(
                  onPressed: () {
                    vm.publish().then(
                      (pid) {
                        context.pushReplacementNamed(
                          "post_detail",
                          pathParameters: {"id": pid.toString()},
                        );
                      },
                    );
                  },
                  child: const Text(
                    "发布",
                    style: TextStyle(color: Colors.blue),
                  ),
                );
              }),
            ],
          );
          return PopScope(
            onPopInvoked: (did) {
              cur.saveCurrentEdittingThread(null);
            },
            child: Scaffold(
              //resizeToAvoidBottomInset: false,
              backgroundColor: Colors.grey.shade200,
              appBar: appBar,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      widget.type == Constants.publishOptionShortText
                          ? PublishPostSelectColor(colors: colors)
                          : const SizedBox(), //只在发布文字时选择背景颜色
                      // 发布图文
                      if (widget.type == Constants.publishOptionTextAndImages)
                        NewPostPicAndTextMain(),
                      // 发布短文字(纯文字)
                      if (widget.type == Constants.publishOptionShortText)
                        NewPostPureTextMain(),
                      // 长文字
                      if (widget.type == Constants.publishOptionLongText)
                        SizedBox(),
                      // 视频
                      if (widget.type == Constants.publishOptionVideo)
                        NewPostVideoAndTextMain(),
                      // 语音
                      if (widget.type == Constants.publishOptionVoice)
                        const NewPostVoiceMain(),
                      // 投票
                      if (widget.type == Constants.publishOptionVote)
                        const NewPostVoteMain(),
                      // 输入框下面的额外信息，展示位置、插入话题、艾特某人
                      const NewPostFooter(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("下面是@的用户，点击用户名可去除"),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        //margin: EdgeInsets.symmetric(vertical: 16),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Wrap(
                          children: vm.atUserList.map(
                            (u) {
                              return GestureDetector(
                                onTap: () => vm.removeAtUser(u),
                                child: Text(
                                  "${u.name}  ",
                                  style: TextStyle(color: Colors.blue.shade400),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      );
    });
  }
}
