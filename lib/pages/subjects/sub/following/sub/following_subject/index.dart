import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/pages/notice/components/go_back_leading.dart';
import 'package:trump/pages/search/components/search_page_subject_item.dart';
import 'package:trump/pages/subjects/sub/following/vm.dart';

// 所有关注的话题
class AllFollowingSubjectPage extends StatelessWidget {
  const AllFollowingSubjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      // todo: 这种顶部两个tab切换，最左边有个返回箭头的，现在都用stack与positioned搭配，不方便。需要优化
      body: ChangeNotifierProvider<FollowingPageViewModel>(
        create: (context) => FollowingPageViewModel(),
        child: Consumer<FollowingPageViewModel>(builder: (context, vm, _) {
          return Stack(
            children: [
              ChangeNotifierProvider<FollowingPageViewModel>.value(
                  value: vm, child: Positioned(child: _Page())),
              const MsgGoBackLeading(),
            ],
          );
        }),
      ),
    );
  }
}

// 关注的城市
class _FollowingCityList extends StatelessWidget {
  const _FollowingCityList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("暂时不支持此功能"));
  }
}

// 关注的话题
class _FollowingSubjectList extends StatefulWidget {
  const _FollowingSubjectList({super.key});

  @override
  State<_FollowingSubjectList> createState() => _FollowingSubjectListState();
}

//todo:note: 下拉刷新用refreshIndicator
class _FollowingSubjectListState extends State<_FollowingSubjectList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FollowingPageViewModel>(builder: (context, vm, child) {
      return RefreshIndicator(
        onRefresh: () async {
          await vm.getFollowingSubjectList();
          setState(() {});
        },
        displacement: 20,
        color: Colors.orange,
        backgroundColor: Colors.white,
        child: ListView.builder(
          itemCount: vm.subjects.length,
          itemBuilder: (context, index) {
            return SearchSubjectItemWithHotValue(subject: vm.subjects[index]);
          },
        ),
      );
    });
  }
}

class _Page extends StatefulWidget {
  const _Page({
    super.key,
  });

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: const [
          TwoTabAppBar(leftText: "关注的话题", rightText: "关注的城市"),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                _FollowingSubjectList(),
                _FollowingCityList(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
