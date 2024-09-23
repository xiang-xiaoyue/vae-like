import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/components/keep_alive_wrapper.dart';
import 'package:trump/models/resp/models/post.dart';
import 'package:trump/pages/mine/sub/collection/vm.dart';
import 'package:trump/pages/notice/export.dart';

class MineCollectionsPage extends StatefulWidget {
  const MineCollectionsPage({super.key});

  @override
  State<MineCollectionsPage> createState() => _MineCollectionsPageState();
}

class _MineCollectionsPageState extends State<MineCollectionsPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 4);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var appBar = CommonAppBar(
      title: "收藏",
      appBarHeight: 76,
      bottom: TabBar(
        dividerColor: Colors.transparent,
        labelPadding: const EdgeInsets.symmetric(horizontal: 26),
        dividerHeight: 0,
        controller: _controller,
        tabs: const [
          Tab(text: "新闻"),
          Tab(text: "行程"),
          Tab(text: "活动"),
          Tab(text: "圈子"),
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: ChangeNotifierProvider<MineCollectionViewModel>(
        create: (context) => MineCollectionViewModel(),
        child: Consumer<MineCollectionViewModel>(builder: (context, vm, _) {
          return TabBarView(
            controller: _controller,
            children: [
              KeepAliveWrapper(child: _BuildPageWrapper(posts: vm.trends)),
              KeepAliveWrapper(child: _BuildPageWrapper(posts: vm.trips)),
              KeepAliveWrapper(child: _BuildPageWrapper(posts: vm.activities)),
              KeepAliveWrapper(child: _BuildPageWrapper(posts: vm.threads)),
            ],
          );
        }),
      ),
    );
  }
}

class _BuildPageWrapper extends StatelessWidget {
  final List<Post> posts;
  const _BuildPageWrapper({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: posts.length + 1,
      itemBuilder: (context, index) {
        if (index == posts.length) {
          return const NoMore();
        }
        return PostItem(post: posts[index]);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 4);
      },
    );
  }
}
