import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/pages/notice/components/go_back_leading.dart';
import 'package:trump/pages/search/components/search_page_subject_item.dart';
import 'package:trump/pages/subjects/sub/following/sub/following_subject/vm.dart';

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
      body: SafeArea(
        child: Stack(
          children: [
            ChangeNotifierProvider<AllFollowingSubjectViewModel>(
                create: (context) => AllFollowingSubjectViewModel(),
                child: const Positioned(child: _Page())),
            const MsgGoBackLeading(),
          ],
        ),
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
    return Consumer<AllFollowingSubjectViewModel>(
        builder: (context, vm, child) {
      return RefreshIndicator(
        onRefresh: () async {
          vm.getList();
          setState(() {});
        },
        displacement: 20,
        color: Colors.orange,
        backgroundColor: Colors.white,
        child: ListView.builder(
          itemCount: vm.count,
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
        children: [
          const TwoTabAppBar(leftText: "关注的话题", rightText: "关注的城市"),
          // Expanded(
          //   child: const TabBarView(
          //     physics: NeverScrollableScrollPhysics(),
          //     children: [
          //       _FollowingSubjectList(),
          //       _FollowingCityList(),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
