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
  final String type;
  const PublishPage({super.key, required this.type});

  @override
  State<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  Widget _getMainTextField(CreatePostViewModel vm) {
    vm.np.type = Constants.postTypeThread;

    if (widget.type == Constants.publishOptionTextAndImages) {
      // 发布图文
      vm.np.subType = Constants.publishOptionTextAndImages;
      return const NewPostPicAndTextMain();
    } else if (widget.type == Constants.publishOptionShortText) {
      // 发布短文字(纯文字)
      vm.np.subType = Constants.publishOptionShortText;
      return const NewPostPureTextMain();
    } else if (widget.type == Constants.publishOptionLongText) {
      // 长文字
      return const SizedBox();
    } else if (widget.type == Constants.publishOptionVideo) {
      // 视频
      vm.np.subType = Constants.postSubTypeVideo;
      return const NewPostVideoAndTextMain();
    } else if (widget.type == Constants.publishOptionVoice) {
      // 语音
      vm.np.subType = Constants.postSubTypeVoice;
      return const NewPostVoiceMain();
    } else if (widget.type == Constants.publishOptionDraft) {
      // 草稿箱
      return const SizedBox();
    } else if (widget.type == Constants.publishOptionVote) {
      // 投票
      vm.np.subType = Constants.postSubTypeVote;
      return const NewPostVoteMain();
    } else if (widget.type == Constants.publishOptionSubject) {
      // 申请话题
      return const SizedBox();
    } else {
      return const SizedBox();
    }
  }

  String selectedColor = '0xffffffff';

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Colors.grey.shade300,
      Colors.teal.shade200,
      Colors.blue.shade200,
      Colors.orange.shade200,
    ];
    return ChangeNotifierProvider<CreatePostViewModel>(
      create: (context) => CreatePostViewModel(),
      child: Consumer<CreatePostViewModel>(builder: (context, vm, child) {
        var appBar = CommonAppBar(
          title: "",
          rightPadding: 0,
          actions: [
            Consumer<CurrentUserViewModel>(builder: (context, curUser, _) {
              return const TextButton(
                onPressed: null,
                child: Text(
                  "存草稿(待做)",
                  style: TextStyle(color: Colors.blue),
                ),
              );
            }),
            Consumer<CurrentUserViewModel>(builder: (context, curUser, _) {
              return TextButton(
                onPressed: () {
                  vm.publish().then(
                    (pid) {
                      curUser.getProfile();
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
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.grey.shade200,
          appBar: appBar,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<CreatePostViewModel>(builder: (context, vm, child) {
              return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    widget.type == Constants.publishOptionShortText
                        ? PublishPostSelectColor(colors: colors)
                        : const SizedBox(), //只在发布文字时选择背景颜色
                    _getMainTextField(vm),
                    // 输入框下面的额外信息，展示位置、插入话题、艾特某人
                    // widget.type == Constants.postSubTypeVideo
                    //     ? Spacer()
                    //     : SizedBox(), //note:让这一块内容相对小键盘定位，用spacer填充其余空间。
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
              );
            }),
          ),
        );
      }),
    );
  }
}

class _Voice {
  const _Voice();
}
