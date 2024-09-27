import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/pages/subjects/components/sample_item.dart';
import 'package:trump/pages/subjects/sub/following/vm.dart';

// 顶部展示关注着的话题，下面是关注的话题里面的post列表
class FollowingTabBarView extends StatefulWidget {
  const FollowingTabBarView({super.key});

  @override
  State<FollowingTabBarView> createState() => _FollowingTabBarViewState();
}

//todo: 未登录用户来此，应当显示“登录后可见”
class _FollowingTabBarViewState extends State<FollowingTabBarView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FollowingPageViewModel>(
      create: (context) => FollowingPageViewModel(),
      child: Consumer<FollowingPageViewModel>(builder: (context, vm, child) {
        return vm.subjectCount == 0
            ? Container(
                alignment: Alignment.center,
                child: Text("没有关注的话题"),
              )
            : RefreshAndLoadMore(
                onRefresh: () async {
                  await vm.getFollowingSubjectList();
                  await vm.getFollowingPostList(requireNewest: true);
                },
                onLoadMore: () async {
                  await vm.getFollowingPostList();
                },
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                        child: _FollowingSubjectBar()), //顶部关注着的话题列表，横向滚动
                    SliverPadding(padding: EdgeInsets.only(bottom: 4)),
                    SliverToBoxAdapter(
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 4),
                        itemCount: vm.posts.length,
                        itemBuilder: (c, i) {
                          return PostItem(post: vm.posts[i]);
                        },
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}

class _FollowingSubjectBar extends StatelessWidget {
  const _FollowingSubjectBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 60,
      child: Stack(
        children: const [
          _FollowingSubjectList(),
          _MoreFollowingSubject(),
        ],
      ),
    );
  }
}

class _MoreFollowingSubject extends StatelessWidget {
  const _MoreFollowingSubject();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      right: 4,
      bottom: 8,
      child: GestureDetector(
        onTap: () {
          context.pushNamed("following_subject_list");
        },
        child: Container(
          alignment: Alignment.center,
          //margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 1),
            ],
          ),
          child: const Text("更多"),
        ),
      ),
    );
  }
}

class _FollowingSubjectList extends StatelessWidget {
  const _FollowingSubjectList();

  @override
  Widget build(BuildContext context) {
    return Consumer<FollowingPageViewModel>(builder: (context, vm, child) {
      return ListView(
        scrollDirection: Axis.horizontal,
        children: vm.subjects.map((item) {
          return SubjectSampleItem(subject: item);
        }).toList(),
      );
    });
  }
}
