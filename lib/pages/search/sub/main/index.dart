import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/pages/search/components/input_area.dart';
import 'package:trump/pages/search/sub/main/section/default_page.dart';
import 'package:trump/pages/search/sub/main/section/result_page.dart';
import 'package:trump/pages/search/sub/main/vm.dart';

class SearchMainPage extends StatefulWidget {
  const SearchMainPage({super.key});

  @override
  State<SearchMainPage> createState() => _SearchMainPageState();
}

class _SearchMainPageState extends State<SearchMainPage> {
  PageController pageController = PageController(initialPage: 0);

  void changeTab(int index) {
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ChangeNotifierProvider<MainSearchViewModel>(
          create: (context) => MainSearchViewModel(),
          child: Consumer<MainSearchViewModel>(builder: (context, vm, child) {
            return Stack(
              children: [
                // Padding(
                //   padding: EdgeInsets.only(
                //       top: vm.isDefaultSearchPage == true ? 70 : 125),
                //   child: vm.isDefaultSearchPage == true
                //       ? const SearchMainDefaultPage()
                //       : SearchMainResultPage(
                //           controller: pageController,
                //           keyword: vm.curKeyword,
                //         ),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(
                //       top: vm.isDefaultSearchPage == true ? 70 : 125),
                //   child: vm.isDefaultSearchPage == true
                //       ? const
                // ),
                Padding(
                  padding: EdgeInsets.only(top: vm.index == 0 ? 70 : 125),
                  child: IndexedStack(
                    index: vm.index,
                    children: [
                      SearchMainDefaultPage(toResult: () {
                        vm.showResult();
                      }),
                      SearchMainResultPage(
                        controller: pageController,
                        keyword: vm.curKeyword,
                      ),
                    ],
                  ),
                ),
                // 顶部搜索框和可选的tabbar
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: _SearchResultTop(changeTab: changeTab),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

// 搜索结果页面的顶部,有搜索框和tab菜单
class _SearchResultTop extends StatefulWidget {
  final Function changeTab;
  const _SearchResultTop({required this.changeTab});

  @override
  State<_SearchResultTop> createState() => _SearchResultTopState();
}

class _SearchResultTopState extends State<_SearchResultTop>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Consumer<MainSearchViewModel>(builder: (context, vm, child) {
        return Column(
          children: [
            SearchInputSection(text: vm.curKeyword),
            vm.isDefaultSearchPage == false
                ? TabBar(
                    controller: tabController,
                    dividerColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 4,
                    ),
                    onTap: (indexValue) {
                      tabController.animateTo(indexValue);
                      vm.changeTab(indexValue);
                      widget.changeTab(indexValue);
                      setState(() {});
                    },
                    indicatorColor: Colors.blue,
                    labelStyle:
                        const TextStyle(color: Colors.blue, fontSize: 16),
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: const [
                      Tab(text: "帖子"),
                      Tab(text: "话题"),
                      Tab(text: "用户"),
                    ],
                  )
                : const SizedBox(),
            Container(
              height: 4,
              color: Colors.grey.withAlpha(100),
            ),
          ],
        );
      }),
    );
  }
}
