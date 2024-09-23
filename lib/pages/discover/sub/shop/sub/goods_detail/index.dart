import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/pages/post/components/comment.dart';
import 'package:trump/pages/post/components/comment_list_header.dart';
import 'package:trump/pages/post/vm.dart';

class GoodsDetailPage extends StatelessWidget {
  final String id;
  const GoodsDetailPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PostDetailViewModel(id: id),
      child: Consumer<PostDetailViewModel>(builder: (context, vm, _) {
        return Scaffold(
          appBar: CommonAppBar(title: "商品详情"),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (vm.post != null)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 180,
                              child: Image.network(
                                vm.post?.posterUrl ?? '',
                                errorBuilder: (ctx, e, st) {
                                  return SizedBox(
                                    height: 180,
                                    child: Center(child: Text("图片加载失败")),
                                  );
                                },
                              ),
                            ),
                            Text(vm.post?.title ?? '无名商品'),
                            Text(
                                "${vm.post!.currencyCount}${vm.post!.currencyType}",
                                style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    SizedBox(height: 4),
                    if (vm.post != null)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vm.post!.content,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                            ),
                            Text('分享到'),
                            Container(height: 60, child: Text("五个分享按钮")),
                          ],
                        ),
                      ),
                    SizedBox(height: 4),
                    CommentListHeader(count: vm.commentCount),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, idx) {
                        return CommentItem(comment: vm.comments[idx]);
                      },
                      itemCount: vm.comments.length,
                    ),
                  ],
                ),
              ),
              _FooterToolBar(),
            ],
          ),
        );
      }),
    );
  }
}

class _FooterToolBar extends StatelessWidget {
  const _FooterToolBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 0.2, color: Colors.blueGrey),
          ),
        ),
        height: 60,
        child: Consumer<PostDetailViewModel>(builder: (context, vm, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  // 点赞post
                  onPressed: () => vm.toggleLikePost(),
                  icon: (vm.post?.isLiking ?? false) == true
                      ? const Icon(Icons.thumb_up, color: Colors.red)
                      : const Icon(Icons.thumb_up_outlined,
                          color: Colors.black)),
              IconButton(
                  // 评论post
                  onPressed: () => context.pushReplacementNamed(
                          "create_comment",
                          queryParameters: {
                            "post_id": vm.post!.id.toString(),
                            "top_id": "0",
                            "parent_id": "0",
                            "parent_content": '',
                          }),
                  icon:
                      const Icon(Icons.comment_outlined, color: Colors.black)),
              Spacer(),
              TrumpButton(
                textColor: Colors.white,
                textSize: 16,
                text: "加入购物车",
                height: 38,
                padding: EdgeInsets.symmetric(horizontal: 8),
                backgroundColor: Colors.blue,
                borderStyle: BorderStyle.none,
                borderRadius: 4,
              ),
            ],
          );
        }),
      ),
    );
  }
}

// 帖子、投票的详情页面主体
// class _ThreadMainSection extends StatelessWidget {
//   const _ThreadMainSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
//
// // 官方动态详情页面主体
// class _TrendMainSection extends StatelessWidget {
//   const _TrendMainSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
// todo: 活动、行程详情页面主体
