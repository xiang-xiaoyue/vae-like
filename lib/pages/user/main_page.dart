import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/pages/mine/vm.dart';
import 'package:trump/pages/user/vm.dart';
import 'package:trump/util/util.dart';

// 用户主页(看自己的主页，多了一个“编辑资料”按钮)
class UserMainPage extends StatefulWidget {
  final String id;
  const UserMainPage({super.key, required this.id});

  @override
  State<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserMainViewModel>(
      create: (context) => UserMainViewModel(widget.id),
      child: Consumer<UserMainViewModel>(builder: (context, vm, child) {
        return Consumer<CurrentUserViewModel>(builder: (context, curUser, _) {
          return Scaffold(
            backgroundColor: Colors.grey.shade300,
            appBar: CommonAppBar(
              title: vm.user?.name ?? '',
              actions: [
                (vm.user != null &&
                        curUser.user != null &&
                        vm.user!.id != curUser.user!.id)
                    ? PopActionSheet(list: [
                        SheetActionItem(
                            text: "拉黑",
                            onTap: () {
                              vm.blockUser().then((_) {
                                context.pop();
                              });
                            }),
                        SheetActionItem(text: "举报", onTap: null),
                        SheetActionItem(
                            text: "取消",
                            onTap: () {
                              context.pop();
                            }),
                      ])
                    : const SizedBox()
              ],
            ),
            body: const _Body(),
          );
        });
      }),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({super.key});

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  int curIdx = 0;
  PageController controller = PageController(initialPage: 0);
  void changeTab(int index) {
    setState(() {
      curIdx = index;
      controller.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserMainViewModel>(builder: (context, vm, child) {
      return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            // todo:展示用户名、头像等信息，有渐隐的动画效果
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 200,
                width: 200,
                color: Colors.blue.shade200,
                child: Consumer<CurrentUserViewModel>(
                    builder: (context, curUser, _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          const Spacer(),
                          _HeaderFollowingInfo(
                              count: vm.user?.followingUserCount ?? 0,
                              label: "关注",
                              onTap: null),
                          _HeaderFollowingInfo(
                              count: vm.user?.fanCount ?? 0,
                              label: "粉丝",
                              onTap: null),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(80),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => vm.likeUser(),
                                  child: Icon(
                                    Icons.favorite_outlined,
                                    color: (vm.user?.isLiking ?? false) == true
                                        ? Colors.red
                                        : Colors.white,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${vm.user?.likeCount ?? 0}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          UserAvatar(
                            url: vm.user?.avatarUrl ?? '',
                            size: 60,
                            onTap: (curUser.user != null &&
                                    vm.user != null &&
                                    curUser.user!.id == vm.user!.id)
                                ? () {
                                    uploadSingleSelectedFile().then((url) {
                                      if (url.contains("http")) {
                                        curUser.user!.avatarUrl = url;
                                        curUser.updateCurrentUser().then((_) {
                                          setState(() {
                                            vm.user!.avatarUrl = url;
                                          });
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                                SnackBar(content: Text(url)));
                                      }
                                    });
                                  }
                                : null,
                          ),
                          const SizedBox(width: 10),
                          Text(vm.user?.name ?? '',
                              style: const TextStyle(fontSize: 20)),
                          const SizedBox(width: 10),
                          const Text("LV.0"),
                          const Spacer(),
                          if (curUser.user != null &&
                              vm.user != null &&
                              vm.user!.id == curUser.user!.id)
                            OutlinedButton(
                              onPressed: () => context.pushNamed("my_profile"),
                              child: const Text(
                                "编辑资料",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          else
                            const SizedBox(),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (curUser.user != null &&
                          vm.user != null &&
                          vm.user!.id != curUser.user!.id)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TrumpButton(
                                text: "私信(待做)",
                                textColor: Colors.white,
                                backgroundColor: Colors.green),
                            TrumpButton(
                              onTap: () => vm.toggleFollowUser(),
                              text: vm.user!.isFollowing == true
                                  ? "取消关注"
                                  : "立即关注",
                              textColor: Colors.white,
                              backgroundColor: vm.user!.isFollowing
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ],
                        )
                      else
                        const SizedBox(),
                    ],
                  );
                }),
              ),
            ),
            _Tabbar(changeTab: changeTab),
          ];
        },
        body: Builder(builder: (context) {
          return PageView(
            controller: controller,
            children: const [
              _TabPageInfo(), // 展示信息
              _TabPageThread(), //展示发布的帖子
            ],
          );
        }),
      );
    });
  }
}

class _HeaderFollowingInfo extends StatelessWidget {
  final int count;
  final String label;

  final Function? onTap;
  const _HeaderFollowingInfo({
    super.key,
    required this.label,
    required this.count,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$count",
          style: const TextStyle(
            height: 1.5,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Text(" $label",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            )),
        const SizedBox(width: 16),
      ],
    );
  }
}

// 展示用户发布的帖子
class _TabPageThread extends StatefulWidget {
  const _TabPageThread({super.key});

  @override
  State<_TabPageThread> createState() => _TabPageThreadState();
}

class _TabPageThreadState extends State<_TabPageThread> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserMainViewModel>(builder: (context, vm, child) {
      return ListView.separated(
        padding: const EdgeInsets.only(top: 4),
        separatorBuilder: (context, index) {
          return const SizedBox(height: 4);
        },
        itemCount: vm.createdPosts.length,
        itemBuilder: (context, index) {
          return PostItem(post: vm.createdPosts[index]);
        },
      );
    });
  }
}

// 展示用户各项信息
class _TabPageInfo extends StatelessWidget {
  const _TabPageInfo({super.key});

  @override
  Widget build(BuildContext context) {
    // 个人信息，签到，相册，纪念卡,勋章，现场经历
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      child: Consumer<UserMainViewModel>(builder: (context, vm, child) {
        return Column(
          children: [
            // 个人信息
            _getTabContentWrap(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "个人信息",
                    style: Constants.titleStyle,
                  ),
                  _InfoItem(label: "签名", value: vm.user?.sign ?? "什么也没有写"),
                  const _InfoItem(label: "人气", value: "0"),
                  const _InfoItem(label: "距离", value: "保密"),
                  const _InfoItem(label: "上线时间", value: "保密"),
                ],
              ),
            ),
            // 签到
            _getTabContentWrap(
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("签到", style: Constants.titleStyle),
                  Text(
                    "连续签到:${vm.user?.seriesCheckinDays ?? 0}天 总签到:${vm.user?.totalCheckinDays ?? 0}天",
                    style: Constants.secondTitleStyle,
                  )
                ],
              ),
            ),

            // 相册
            // todo: 纪念卡
            // todo: 勋章
            // todo: 现场经历
          ],
        );
      }),
    );
  }

  Container _getTabContentWrap(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 16),
      child: child,
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;
  const _InfoItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
        child: Row(
          children: [
            SizedBox(width: 80, child: Text(label)),
            Expanded(
              // note: row里面text容易溢出，用expanded包裹，
              child: Text(
                value,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageView extends StatefulWidget {
  const _PageView({super.key});

  @override
  State<_PageView> createState() => _PageViewState();
}

class _PageViewState extends State<_PageView> {
  PageController controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller,
      children: const [
        Center(child: Text("one")),
        Center(child: Text("two")),
      ],
    );
  }
}

class _Tabbar extends StatefulWidget {
  final Function changeTab;
  const _Tabbar({
    super.key,
    required this.changeTab,
  });

  @override
  State<_Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<_Tabbar> with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeaderDelegate(
        maxHeight: 50,
        minHeight: 50,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          child: TabBar(
            controller: controller,
            labelStyle: const TextStyle(color: Colors.blue, fontSize: 18),
            indicatorColor: Colors.blue,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 4),
            dividerHeight: 0,
            unselectedLabelColor: Colors.grey.shade600,
            padding: const EdgeInsets.symmetric(horizontal: 100),
            onTap: (value) => widget.changeTab(value),
            tabs: const [
              Tab(text: "信息"),
              Tab(text: "帖子"),
            ],
          ),
        ),
      ),
    );
  }
}
