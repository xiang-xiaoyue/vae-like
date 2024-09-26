// 热门
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/pages/notice/export.dart';
import 'package:trump/pages/subjects/sub/hot/vm.dart';

class HotTabBarView extends StatefulWidget {
  const HotTabBarView({super.key});

  @override
  State<HotTabBarView> createState() => _HotTabBarViewState();
}

class _HotTabBarViewState extends State<HotTabBarView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HotPostViewModel>(
      create: (context) => HotPostViewModel(),
      child: Consumer<HotPostViewModel>(builder: (context, vm, child) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: RefreshAndLoadMore(
            onRefresh: () async => vm.getList(requireNewest: true),
            onLoadMore: () async => vm.getList(),
            child: ListView.separated(
              itemCount: vm.count + 1,
              itemBuilder: (context, index) {
                if (index == vm.count) {
                  return NoMore();
                }
                return PostItem(post: vm.posts[index]);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 4);
              },
            ),
          ),
        );
      }),
    );
    /*
    return ListView.builder(
      itemCount: 30,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.blueGrey.withAlpha(50),
          padding: const EdgeInsets.only(top: 4),
          child: Container(
            //padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: PostItem(),
          ),
        );
      },
    );
        */
  }
}
