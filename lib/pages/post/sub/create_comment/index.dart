// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/components/toast.dart';
import 'package:trump/pages/post/sub/create_comment/vm.dart';
import 'package:trump/pages/publish/components/pic_item.dart';
import 'package:trump/pages/publish/components/upload_pic.dart';

// 创建评论的页面
class CreateCommentPage extends StatelessWidget {
  final String postId;
  final String topId;
  String parentId;
  String parentContent;
  String uname;
  CreateCommentPage({
    super.key,
    required this.topId,
    required this.postId,
    required this.parentId,
    required this.parentContent,
    required this.uname,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateCommentViewModel>(
      create: (context) => CreateCommentViewModel(
        postId: postId,
        topId: topId,
        parentId: parentId,
        parentContent: parentContent,
        uname: uname,
      ),
      child: Consumer<CreateCommentViewModel>(builder: (context, vm, _) {
        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          appBar: CommonAppBar(
            title: "评论",
            rightPadding: 0,
            actions: [
              TextButton(
                onPressed: () {
                  vm.publishComment().then((success) {
                    if (success == true) {
                      context.pop(true);
                    } else {
                      context.showToast("评论失败");
                    }
                  });
                },
                child: const Text(
                  "发布",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  parentContent.isNotEmpty
                      ? _ParentCommentInfo(uname: uname, content: parentContent)
                      : const SizedBox(),
                  // 回复区
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _TextArea(uname: uname),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            // 图片和语音二选一
                            // 上传图片
                            vm.comment.picUrl != ""
                                ? PublishDisplayPicItem(
                                    url: vm.comment.picUrl,
                                    remove: () {
                                      vm.comment.picUrl = "";
                                      vm.notify();
                                    },
                                  )
                                : ItemForUpload(upload: (url) {
                                    vm.comment.picUrl = url;
                                    vm.notify();
                                  }),
                            SizedBox(width: 10),
                            // todo:上传录音
                            // ItemForUpload(
                            //   upload: () {},
                            //   iconData: Icons.mic,
                            // ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text.rich(
                          TextSpan(
                            text: "TIPS : ",
                            style: TextStyle(color: Colors.blue, fontSize: 18),
                            children: [
                              TextSpan(
                                //text: " 您可以选择图片或语音",
                                text: " 您现在只可以选择图片",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _TextArea extends StatefulWidget {
  String? uname;
  _TextArea({
    super.key,
    this.uname = '',
  });

  @override
  State<_TextArea> createState() => _TextAreaState();
}

class _TextAreaState extends State<_TextArea> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CreateCommentViewModel>(builder: (context, vm, _) {
      return TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "回复 ${widget.uname}：",
          border: InputBorder.none,
        ),
        onChanged: (v) {
          setState(() {
            vm.comment.content = v.trim();
          });
        },
        maxLength: 250,
        maxLines: null,
        minLines: 7,
      );
    });
  }
}

class _ParentCommentInfo extends StatelessWidget {
  final String uname;
  final String content;
  const _ParentCommentInfo({
    super.key,
    this.uname = '',
    this.content = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "回复 $uname",
          style: TextStyle(color: Colors.grey.shade800, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 18),
              ),
              //todo: 展开与收起,go_router,extra传递完整parent
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
