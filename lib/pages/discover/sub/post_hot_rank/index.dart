import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/components/tem_placeholder.dart';
import 'package:trump/pages/discover/sub/post_hot_rank/vm.dart';

// 最热帖子排行
class PostRankPage extends StatelessWidget {
  const PostRankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostHotRankViewModel>(
      create: (context) => PostHotRankViewModel(),
      child: Consumer<PostHotRankViewModel>(builder: (context, vm, child) {
        return Scaffold(
          appBar: CommonAppBar(title: "最热帖子排行"),
          body: ListView.separated(
            separatorBuilder: (ctx, idx) {
              return SizedBox(height: 4);
            },
            itemBuilder: (ctx, idx) {
              return PostItem(post: vm.posts[idx]);
            },
            itemCount: vm.posts.length,
          ),
        );
      }),
    );
  }
}
