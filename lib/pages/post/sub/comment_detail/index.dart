import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/pages/notice/export.dart';
import 'package:trump/pages/post/components/comment_list_header.dart';
import './vm.dart';

import '../../components/comment.dart';

// 评论详情页面
class CommentDetailPage extends StatefulWidget {
  final String id;
  const CommentDetailPage({
    super.key,
    required this.id,
  });

  @override
  State<CommentDetailPage> createState() => _CommentDetailPageState();
}

class _CommentDetailPageState extends State<CommentDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CommentDetailViewModel>(
      create: (context) => CommentDetailViewModel(widget.id),
      child: Scaffold(
        appBar: const CommonAppBar(title: "评论详情"),
        body: SingleChildScrollView(
          child: const _Main(),
        ),
      ),
    );
  }
}

class _Main extends StatefulWidget {
  const _Main({
    super.key,
  });

  @override
  State<_Main> createState() => _MainState();
}

class _MainState extends State<_Main> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CommentDetailViewModel>(builder: (context, vm, child) {
      return Column(
        children: [
          vm.comment == null
              ? SizedBox()
              : CommentItem(comment: vm.comment!, isCommentDetailPage: true),
          vm.comment == null
              ? SizedBox()
              : CommentListHeader(count: vm.comment!.childCount),
          // 回复列表
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: vm.replyCount + 1,
            itemBuilder: (context, index) {
              if (index == vm.replyCount) {
                return const NoMore();
              }
              return CommentItem(comment: vm.replyList[index]);
            },
          ),
        ],
      );
    });
  }
}
