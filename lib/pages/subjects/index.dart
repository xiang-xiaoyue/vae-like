//圈子页面
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/bottom_navigator_bar.dart';
import 'package:trump/components/toast.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/pages/mine/vm.dart';
import 'package:trump/pages/subjects/export.dart';
import 'package:trump/pages/subjects/sub/maidan/index.dart';
import 'package:trump/service/save.dart';
import 'package:trump/util/guard.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({super.key});

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  final _tabs = [
    const Tab(text: ("广场")),
    const Tab(text: ("热门")),
    const Tab(text: ("关注")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        //onPressed: () => context.pushNamed("for_test"),
        onPressed: () => context.showToast("hello"),
        child: Text("toTest"),
      ),
      bottomNavigationBar: const TrumpBottomNavigatorBar(),
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              padding: EdgeInsets.only(top: TrumpSize.appBarHeight),
              child: TabBarView(
                controller: _controller,
                children: const [
                  MaidanTabBarView(),
                  HotTabBarView(),
                  FollowingTabBarView(),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: SizedBox(
                height: 48,
                child: _AppBar(tabs: _tabs, controller: _controller),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    required List<Tab> tabs,
    required TabController controller,
  })  : _tabs = tabs,
        _controller = controller;

  final List<Tab> _tabs;
  final TabController _controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          elevation: 0,
          bottom: TabBar(
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 8),
            indicator: const BoxDecoration(
              color: Colors.transparent,
              border: Border(
                bottom: BorderSide(width: 2, color: Colors.blue),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 100),
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: _tabs,
            //labelColor: Colors.blue,
            labelStyle: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            controller: _controller,
          ),
        ),
        // 添加按钮和搜索按钮
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              GestureDetector(
                child: const Icon(Icons.search),
                onTap: () {
                  context.pushNamed("search");
                },
              ),
              const Spacer(),
              Consumer<CurrentUserViewModel>(builder: (context, cur, _) {
                return PopupMenuButton(
                  color: Colors.white,
                  itemBuilder: (context) => buildItems(),
                  child: const Icon(Icons.add_circle_outline_rounded),
                  onSelected: (value) {
                    // authGuard().then((isLoggedIn) {
                    //   if (isLoggedIn == false) {
                    //     context.pushReplacementNamed("login");
                    //     return;
                    //   }
                    // });
                    if (cur.isLoggedIn == false) {
                      context.pushReplacementNamed("login");
                      return;
                    } else if (value == Constants.publishOptionDraft) {
                      // 去草稿箱
                      //context.pushNamed("draft");
                      context.showToast("现在还没有实现此功能");
                      return;
                    } else if (value == Constants.publishOptionSubject) {
                      // 去申请话题
                      context.pushNamed("subject_apply");
                      return;
                    } else if (value == Constants.publishOptionVideo) {
                      if ((cur.user?.level ?? 0) < 10) {
                        context.showToast("等级不够，不能上传视频，请等级达到10级再来");
                        return;
                      }
                    }
                    //todo: 长文、图文等类型暂时不能发布
                    else if (value == Constants.publishOptionLongText) {
                      context.showToast("现在还没有实现此功能");
                      return;
                    } else {
                      context.pushNamed(
                        "publish",
                        queryParameters: {"type": value},
                      );
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}

List<PopupMenuItem<String>> buildItems() {
  Map<String, String> ms = {
    Constants.publishOptionTextAndImages: "图文",
    Constants.publishOptionShortText: "短文",
    Constants.publishOptionLongText: "长文(待做)",
    Constants.publishOptionVoice: "语音",
    Constants.publishOptionVideo: "视频",
    Constants.publishOptionDraft: "草稿箱(待做)",
    Constants.publishOptionVote: "投票",
    Constants.publishOptionSubject: "申请话题",
  };
  return ms.keys.map((k) {
    return PopupMenuItem(value: k.toString(), child: Text(ms[k].toString()));
  }).toList();
}
