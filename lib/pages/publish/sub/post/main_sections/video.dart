import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/pages/publish/components/upload_bar.dart';
import 'package:trump/pages/publish/components/upload_pic.dart';
import 'package:trump/pages/publish/sub/post/conponents/content_input.dart';
import 'package:trump/pages/publish/sub/post/vm.dart';

// 只能上传一个视频
class NewPostVideoAndTextMain extends StatefulWidget {
  const NewPostVideoAndTextMain({super.key});

  @override
  State<NewPostVideoAndTextMain> createState() =>
      _NewPostVideoAndTextMainState();
}

class _NewPostVideoAndTextMainState extends State<NewPostVideoAndTextMain> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CreatePostViewModel>(builder: (context, vm, child) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
        child: Consumer<CreatePostViewModel>(builder: (context, vm, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NewPostTextarea(onChange: (v) => vm.np.content = v.trim()),
              Text("等级达到10级才可上传视频"),
              vm.np.videoUrl != ""
                  ? UserAvatar(
                      url: vm.np.posterUrl,
                      size: 112,
                      radius: 0,
                    )
                  : SelectAndUploadBar(
                      setFileUrl: (fileUrl) {
                        vm.np.videoUrl = fileUrl;
                        vm.notify();
                      },
                      setPicUrl: (picUrl) {
                        vm.np.posterUrl = picUrl;
                        vm.notify();
                      },
                    ),
            ],
          );
        }),
      );
    });
  }
}
