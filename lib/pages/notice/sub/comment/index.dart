import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/pages/mine/vm.dart';
import 'package:trump/pages/notice/components/go_back_leading.dart';
import 'package:trump/pages/notice/components/item_card.dart';
import 'package:trump/pages/notice/sub/comment/vm.dart';

class CommentNoticePage extends StatelessWidget {
  const CommentNoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(child: _Page()),
            MsgGoBackLeading(),
          ],
        ),
      ),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TwoTabAppBar(
            leftText: "评论我的",
            rightText: "我评论的",
          ),
          Consumer<CurrentUserViewModel>(builder: (context, curUser, child) {
            return curUser.user == null
                ? SizedBox()
                : Expanded(
                    child: ChangeNotifierProvider<CommentNoticeViewModel>(
                      create: (context) => CommentNoticeViewModel(),
                      child: Consumer<CommentNoticeViewModel>(
                          builder: (context, vm, child) {
                        return TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: vm.commentsToMe.length,
                              itemBuilder: (ctx, idx) {
                                return NoticeItem(notice: vm.commentsToMe[idx]);
                              },
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: vm.myComments.length,
                              itemBuilder: (ctx, idx) {
                                return NoticeItem(notice: vm.myComments[idx]);
                              },
                            ),
                          ],
                        );
                      }),
                    ),
                  );
          }),
        ],
      ),
    );
  }
}
