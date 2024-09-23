import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/app_bar.dart';
import 'package:trump/pages/home/sub/hot_user_content/vm.dart';
import 'package:trump/pages/notice/export.dart';
import '../../components/hot_user_content_item.dart';

//todo:改名，改成'hot-user'
// title-role 发布的内容页面，包括words和评论等
class HotUserContentPage extends StatelessWidget {
  const HotUserContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "hot-user来了"),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: const _List(),
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HotUserContentViewModel>(
      create: (context) => HotUserContentViewModel(),
      child: Consumer<HotUserContentViewModel>(builder: (context, vm, child) {
        return ListView.separated(
          itemBuilder: (context, index) {
            if (index == vm.contentCount) {
              return NoMore();
            }
            return HotUserContentItem(
                content: vm.contentList[index], isLast: index == 0);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
          itemCount: vm.contentCount + 1,
        );
      }),
    );
  }
}
