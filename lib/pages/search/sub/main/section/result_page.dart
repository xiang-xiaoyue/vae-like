import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/pages/notice/export.dart';
import 'package:trump/pages/search/components/search_nothing.dart';
import 'package:trump/pages/search/components/search_page_subject_item.dart';
import 'package:trump/pages/search/components/user_item.dart';
import 'package:trump/pages/search/sub/main/vm.dart';

// 展示搜索结果列表
class SearchMainResultPage extends StatefulWidget {
  final String keyword;
  final PageController controller;
  const SearchMainResultPage({
    super.key,
    required this.keyword,
    required this.controller,
  });

  @override
  State<SearchMainResultPage> createState() => _SearchMainResultPageState();
}

class _SearchMainResultPageState extends State<SearchMainResultPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainSearchViewModel>(builder: (context, vm, child) {
      return PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: widget.controller,
        onPageChanged: (value) {
          setState(() {});
        },
        scrollDirection: Axis.horizontal,
        children: const [
          KeepAliveWrapper(child: _ThreadResultSection()),
          KeepAliveWrapper(child: _SubjectResultSection()),
          KeepAliveWrapper(child: _UserResultSection()),
        ],
      );
    });
  }
}

// 展示返回的帖子列表
class _ThreadResultSection extends StatelessWidget {
  const _ThreadResultSection();

  @override
  Widget build(BuildContext context) {
    return Consumer<MainSearchViewModel>(builder: (context, vm, child) {
      return vm.postCount == 0
          ? const NoMore()
          : Center(
              child: ListView.builder(
                itemCount: vm.postCount + 1,
                itemBuilder: (context, index) {
                  if (index == vm.postCount) {
                    return const NoMore();
                  }
                  return PostItem(post: vm.postList[index]);
                },
              ),
            );
    });
  }
}

// 展示返回的subjec列表
class _SubjectResultSection extends StatefulWidget {
  const _SubjectResultSection();

  @override
  State<_SubjectResultSection> createState() => _SubjectResultSectionState();
}

class _SubjectResultSectionState extends State<_SubjectResultSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainSearchViewModel>(builder: (context, vm, child) {
      return vm.subjectCount == 0
          ? const SearchNothing(text: "暂时没有结果，尝试申请相关话题！")
          : Center(
              child: ListView.builder(
                itemCount: vm.subjectCount + 1,
                itemBuilder: (context, index) {
                  if (index == vm.subjectCount) {
                    return const NoMore();
                  }
                  return SearchSubjectItemWithHotValue(
                    subject: vm.subjectList[index],
                  );
                },
              ),
            );
    });
  }
}

// 返回user列表
class _UserResultSection extends StatelessWidget {
  const _UserResultSection();

  @override
  Widget build(BuildContext context) {
    return Consumer<MainSearchViewModel>(
      builder: (context, vm, child) {
        return vm.userCount == 0
            ? const SearchNothing(text: "什么也没发现")
            : Center(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: vm.userCount + 1,
                        itemBuilder: (context, index) {
                          if (index == vm.userCount) {
                            // 最后 一个也渲染完了。
                            return const NoMore();
                          }
                          return SearchUserItem(
                            user: vm.userList[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
