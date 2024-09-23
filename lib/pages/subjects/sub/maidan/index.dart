import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/avatar.dart';
import 'package:trump/components/index.dart';
import 'package:trump/models/resp/models/subject.dart';
import 'package:trump/pages/notice/export.dart';
import 'package:trump/pages/subjects/sub/maidan/vm.dart';

// 广场
class MaidanTabBarView extends StatefulWidget {
  const MaidanTabBarView({super.key});

  @override
  State<MaidanTabBarView> createState() => _MaidanTabBarViewState();
}

class _MaidanTabBarViewState extends State<MaidanTabBarView> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MaidanPageViewModel>(
      create: (context) => MaidanPageViewModel(),
      child: Consumer<MaidanPageViewModel>(builder: (context, vm, _) {
        return RefreshIndicator(
          displacement: 20,
          color: Colors.red,
          backgroundColor: Colors.orange,
          onRefresh: () async {
            vm.getRecommendedSubjectList();
            vm.getSubjectList();
            vm.getPostList(requireNewest: true);
          },
          child: NotificationListener<ScrollNotification>(
            onNotification: (nf) {
              if (nf.metrics.pixels + 30 >= nf.metrics.maxScrollExtent) {
                if (vm.isLoadingPostList == true) {
                  // 正在加载数据
                } else {
                  if (vm.noMoreOldPost == false) {
                    vm.setIsLoadingPostList(true);
                    vm.getPostList(requireNewest: false).then((_) {
                      vm.setIsLoadingPostList(false);
                    });
                  }
                }
              }
              return false;
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const _RecommendedSubjectList(),
                  const _HotSubjectListHeader(),
                  const _HotSubjectList(),
                  ListView.separated(
                    separatorBuilder: (ctx, idx) => const SizedBox(height: 4),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: vm.posts.length + 1,
                    itemBuilder: (ctx, idx) {
                      if (idx == vm.posts.length) {
                        return NoMore();
                      }
                      return PostItem(post: vm.posts[idx]);
                    },
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

class _HotSubjectListHeader extends StatelessWidget {
  const _HotSubjectListHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: const AppDoubleText(left: "热门话题", right: "更多"),
    );
  }
}

class _HotSubjectList extends StatelessWidget {
  const _HotSubjectList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.white,
        height: 140,
        child: Consumer<MaidanPageViewModel>(builder: (context, vm, child) {
          return GridView.extent(
            shrinkWrap: true,
            maxCrossAxisExtent: 60,
            scrollDirection: Axis.horizontal,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio: 2 / 8,
            children: vm.subjects.map((s) {
              return NewWidget(subject: s);
            }).toList(),
          );
        }),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  final Subject subject;
  const NewWidget({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          context.pushNamed(
            "subject_detail",
            queryParameters: {"id": subject.id.toString()},
          );
        },
        child: Text.rich(
          TextSpan(
            text: "#",
            style: const TextStyle(color: Colors.blue),
            children: [
              TextSpan(
                text: subject.name,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecommendedSubjectList extends StatefulWidget {
  const _RecommendedSubjectList({super.key});

  @override
  State<_RecommendedSubjectList> createState() =>
      _RecommendedSubjectListState();
}

class _RecommendedSubjectListState extends State<_RecommendedSubjectList> {
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 220,
        color: Colors.white,
        child: Consumer<MaidanPageViewModel>(builder: (context, vm, child) {
          return Column(
            children: [
              // 话题列表主体
              SizedBox(
                height: 180,
                width: double.infinity,
                child: _RecommendedSubjectBody(changePage: (index) {
                  setState(() => _pageIndex = index);
                }),
              ),
              // 点列表
              const Spacer(),
              Container(
                height: 25,
                alignment: Alignment.center,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: (vm.recommendedSubjects.length % 8) > 0
                      ? (vm.recommendedSubjects.length ~/ 8) + 1
                      : (vm.recommendedSubjects.length ~/ 8),
                  itemBuilder: (context, index) {
                    return Center(
                      child: Container(
                        margin: const EdgeInsets.only(right: 4),
                        width: index == _pageIndex ? 12 : 8,
                        height: 4,
                        decoration: BoxDecoration(
                          color:
                              index == _pageIndex ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

class _RecommendedSubjectBody extends StatelessWidget {
  final Function(int) changePage;
  const _RecommendedSubjectBody({super.key, required this.changePage});

  @override
  Widget build(BuildContext context) {
    return Consumer<MaidanPageViewModel>(builder: (context, vm, child) {
      return PageView.builder(
        itemCount: (vm.recommendedSubjects.length % 8) > 0
            ? (vm.recommendedSubjects.length ~/ 8) + 1
            : (vm.recommendedSubjects.length ~/ 8),
        onPageChanged: changePage,
        itemBuilder: (BuildContext context, int index) {
          return ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: GridView.builder(
              padding: EdgeInsets.only(top: 4),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: (index < (vm.recommendedSubjects.length ~/ 8))
                  ? 8
                  : (vm.recommendedSubjects.length % 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 8 / 7,
              ),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, position) {
                return Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UserAvatar(
                          url: vm.recommendedSubjects[position].coverUrlList,
                          size: 50),
                      Text(
                        vm.recommendedSubjects[position].name,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    });
  }
}
