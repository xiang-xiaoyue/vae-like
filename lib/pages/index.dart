import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/components/toast.dart';
import 'package:trump/pages/discover/index.dart';
import 'package:trump/pages/home/index.dart';
import 'package:trump/pages/mine/index.dart';
import 'package:trump/pages/notice/index.dart';
import 'package:trump/pages/subjects/index.dart';
import 'package:trump/vm.dart';

// 切换：首页、圈子、发现、消息、我的
class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalViewModel>(builder: (context, global, _) {
      return Scaffold(
        backgroundColor:
            global.curIdx == 1 ? Colors.grey.shade300 : Colors.white,
        bottomNavigationBar:
            TrumpBottomNavigatorBar(controller: pageController),
        appBar: global.curIdx == 1
            ? AppBar(
                toolbarHeight: 0,
                backgroundColor: Colors.white,
                scrolledUnderElevation: 0, // 上滑时让顶部栏看起来没有阴影
              )
            : null,
        floatingActionButton: FloatingActionButton(
          //onPressed: () => context.pushNamed("for_test"),
          onPressed: () => context.showToast("hello"),
          child: Text("toTest"),
        ),
        body: Consumer<GlobalViewModel>(builder: (context, global, _) {
          return PageView(
            controller: pageController,
            onPageChanged: (index) {
              global.setCurIdx(index);
            },
            physics: NeverScrollableScrollPhysics(),
            children: const [
              KeepAliveWrapper(child: HomePage()),
              KeepAliveWrapper(child: SubjectPage()),
              KeepAliveWrapper(child: DiscoverPage()),
              KeepAliveWrapper(child: NoticeIndexPage()),
              KeepAliveWrapper(child: MinePage())
            ],
          );
        }),
      );
    });
  }
}

class TrumpBottomNavigatorBar extends StatefulWidget {
  final PageController controller;
  const TrumpBottomNavigatorBar({
    super.key,
    required this.controller,
  });

  @override
  State<TrumpBottomNavigatorBar> createState() =>
      _TrumpBottomNavigatorBarState();
}

class _TrumpBottomNavigatorBarState extends State<TrumpBottomNavigatorBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalViewModel>(builder: (context, vm, _) {
      return PopScope(
        onPopInvoked: (d) {
          vm.popIdx();
        },
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: vm.curIdx,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          selectedItemColor: Colors.blueAccent,
          onTap: (v) {
            setState(() {
              vm.setCurIdx(v);
              widget.controller.jumpToPage(v);
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "trump"),
            BottomNavigationBarItem(icon: Icon(Icons.circle), label: "圈子"),
            BottomNavigationBarItem(icon: Icon(Icons.discord), label: "发现"),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: "消息"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
          ],
        ),
      );
    });
  }
}
