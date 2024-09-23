import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/buttons/outlined.dart';
import 'package:trump/components/index.dart';
import 'package:trump/pages/notice/export.dart';
import 'package:trump/pages/subjects/sub/detail/vm.dart';

// 话题详情页面
// todo:现在ave相同效果，顶部不是hero动画，而是滑动到一定程序，appbar被替换了
class SubjectDetailPage extends StatefulWidget {
  final String id;
  const SubjectDetailPage({super.key, required this.id});

  @override
  State<SubjectDetailPage> createState() => _SubjectDetailPageState();
}

class _SubjectDetailPageState extends State<SubjectDetailPage> {
  final ScrollController _controller = ScrollController();
  bool _menuIsTop = false;
  double trans = 1;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      double offset = _controller.offset;
      setState(() {
        _menuIsTop = offset >= 200.0;
        trans = 1 - offset / 200;
        if (trans > 1) {
          trans = 1;
        } else if (trans < 0) {
          trans = 0;
        }
      });
    });
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SubjectDetailViewModel>(
      create: (context) => SubjectDetailViewModel.init(widget.id),
      child: Consumer<SubjectDetailViewModel>(builder: (context, vm, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CommonAppBar(
            title: vm.subject?.name ?? 'none',
            titleOpacity: 1 - trans,
            backgrounColor: Colors.blue.withOpacity(trans),
            actions: [
              vm.subject?.isFollowing == true
                  ? Opacity(
                      opacity: 1 - trans,
                      child: TrumpOutlinedButton(
                        text: "取消关注",
                        onTap: () {
                          vm.toggleFollowSubject();
                        },
                      ),
                    )
                  : Opacity(
                      opacity: 1 - trans,
                      child: TrumpOutlinedButton(
                        text: "关注",
                        onTap: () {
                          vm.toggleFollowSubject();
                        },
                      ),
                    )
            ],
          ),
          body: Consumer<SubjectDetailViewModel>(builder: (context, vm, child) {
            var placeholderHeight = SliverToBoxAdapter(
                child: SizedBox(
                    height: 4, child: ColoredBox(color: Colors.grey.shade200)));
            return CustomScrollView(
              controller: _controller,
              slivers: [
                const _SubjectDetailPanel(),
                _MenusBar(menuIsTop: _menuIsTop), // 最新、精华、排序
                placeholderHeight,
                SliverToBoxAdapter(
                  child: IndexedStack(
                    alignment: Alignment.topCenter,
                    index: vm.curIdx,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, idx) {
                          if (idx == vm.threads.length) {
                            return const NoMore();
                          }
                          return PostItem(post: vm.threads[idx]);
                        },
                        itemCount: vm.threads.length + 1,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, idx) {
                          if (idx == vm.gloryThreads.length) {
                            return const NoMore();
                          }
                          return PostItem(post: vm.gloryThreads[idx]);
                        },
                        itemCount: vm.gloryThreads.length + 1,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        );
      }),
    );
  }
}

class _MenusBar extends StatefulWidget {
  const _MenusBar({
    super.key,
    required bool menuIsTop,
  }) : _menuIsTop = menuIsTop;

  final bool _menuIsTop;

  @override
  State<_MenusBar> createState() => _MenusBarState();
}

class _MenusBarState extends State<_MenusBar> {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeaderDelegate(
        maxHeight: 52,
        minHeight: 52,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
            border: Border(top: BorderSide(width: 0.2, color: Colors.grey)),
          ),
          child: Container(
            width: double.infinity,
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: widget._menuIsTop
                  ? BorderRadius.circular(0)
                  : const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
            ),
            child: Consumer<SubjectDetailViewModel>(builder: (context, vm, _) {
              return Row(
                children: [
                  CustomTabMenuItem(
                    text: "最新",
                    isActive: vm.curIdx == 0,
                    onTap: () => vm.setCurIdx(0),
                  ),
                  CustomTabMenuItem(
                    text: "精华",
                    isActive: vm.curIdx == 1,
                    onTap: () => vm.setCurIdx(1),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: null,
                    child: const Text("排序"),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

class CustomTabMenuItem extends StatelessWidget {
  final String text;
  final Function onTap;
  final bool isActive;
  const CustomTabMenuItem({
    super.key,
    required this.text,
    required this.onTap,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 52,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const Spacer(),
            Text(text),
            isActive == true
                ? Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 2,
                        width: 12,
                        color: Colors.red,
                      ),
                    ),
                  )
                : const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _SubjectDetailPanel extends StatelessWidget {
  const _SubjectDetailPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<SubjectDetailViewModel>(builder: (context, vm, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 200,
          color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    vm.subject?.name ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  TrumpOutlinedButton(
                    text: vm.subject?.isFollowing == true ? "取消关注" : "关注",
                    textColor: Colors.white,
                    borderColor: Colors.white,
                    onTap: () {
                      vm.toggleFollowSubject();
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "0点热度 - ${vm.subject?.followingUserCount}人关注",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade400,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vm.subject?.summary ?? vm.subject?.name ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed("subject_item_detail",
                                queryParameters: {
                                  "id": (vm.subject?.id ?? 0).toString()
                                });
                          },
                          child: Text(
                            "查看详情->",
                            style: TextStyle(
                                fontSize: 12, color: Colors.yellow.shade400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
