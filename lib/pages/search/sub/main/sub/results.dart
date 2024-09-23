import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/pages/notice/components/go_back_leading.dart';
import 'package:trump/pages/search/sub/main/sub/vm.dart';

class SearchResultListPage extends StatelessWidget {
  final String type;
  const SearchResultListPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: ChangeNotifierProvider<SearchResultViewModel>(
          create: (context) => SearchResultViewModel.init(type),
          child: Stack(
            children: [
              Positioned(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      _getAppBar(type),
                      Expanded(
                        child: _ListSection(),
                      ),
                    ],
                  ),
                ),
              ),
              const MsgGoBackLeading(),
            ],
          ),
        ),
      ),
    );
  }

  TwoTabAppBar _getAppBar(String type) {
    String left = '未知';
    String right = '未知';
    switch (type) {
      case Constants.postSubTypeShortText:
        left = "最新文字帖";
        right = "最热文字帖";
        break;
      case Constants.postSubTypeVideo:
        left = "最新视频";
        right = "最热视频";
        break;
      case Constants.postSubTypeLongText:
        left = "最新长文";
        right = "最热长文";
        break;
      case Constants.postSubTypeVoice:
        left = "最新语音";
        right = "最热语音";
        break;
      case Constants.postSubTypeTextWithImages:
        left = "最新图文帖";
        right = "最热图文帖";
        break;
    }
    return TwoTabAppBar(leftText: left, rightText: right);
  }
}

class _ListSection extends StatefulWidget {
  const _ListSection({
    super.key,
  });

  @override
  State<_ListSection> createState() => _ListSectionState();
}

class _ListSectionState extends State<_ListSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchResultViewModel>(builder: (context, vm, child) {
      return TabBarView(
        children: [
          //todo:note: 这里的list少渲染一条，要手动给itemCount加1,原因没找到。
          ListView.separated(
            itemBuilder: (ctx, idx) {
              return const SizedBox(height: 4);
            },
            separatorBuilder: (ctx, idx) {
              return PostItem(post: vm.latestPostList[idx]);
            },
            itemCount: vm.latestPostCount + 1,
          ),
          ListView.separated(
            itemBuilder: (ctx, idx) {
              return const SizedBox(height: 10);
            },
            separatorBuilder: (ctx, idx) {
              return PostItem(post: vm.hotPostList[idx]);
            },
            itemCount: vm.hotPostCount + 1,
          ),
        ],
      );
    });
  }
}

class _Page extends StatelessWidget {
  const _Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
