import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/exports.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/pages/notice/export.dart';
import 'package:trump/pages/search/sub/group/vm.dart';

// 发现群组页面，展示全部群组，根据输入的关键词过滤
class SearchGroupPage extends StatelessWidget {
  const SearchGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider<SearchGroupListViewModel>(
        create: (context) => SearchGroupListViewModel(),
        child: SafeArea(
          child: Consumer<SearchGroupListViewModel>(builder: (context, vm, _) {
            return Stack(
              children: [
                // 群组列表
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: TrumpSize.searchAppBarHeight),
                  itemCount: vm.filteredList.length + 1,
                  itemBuilder: (context, index) {
                    if (vm.filteredList.length == index) {
                      return const NoMore();
                    }
                    return SearchGroupItem(gs: vm.filteredList[index]);
                  },
                ),
                SearchAppBar(
                  onCancel: () {
                    vm.filterList("");
                  },
                  onSubmit: (keyword) => vm.filterList(keyword),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
