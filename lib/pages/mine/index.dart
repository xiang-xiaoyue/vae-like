import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/avatar.dart';
import 'package:trump/components/bottom_navigator_bar.dart';
import 'package:trump/components/buttons/button.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/pages/mine/vm.dart';

//“我的”页面
class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentUserViewModel>(builder: (context, vm, _) {
      return vm.isLoggedIn == true
          ? SingleChildScrollView(
              child: Column(
                children: [
                  const _MineInfoPanel(),
                  if (vm.user != null)
                    ...mineMenus.map((m) {
                      if (m == null) {
                        return const SizedBox(height: 16);
                      } else {
                        return MenuListItem(menu: m);
                      }
                    }),
                ],
              ),
            )
          : const _NotLogin();
    });
  }
}

class _NotLogin extends StatelessWidget {
  const _NotLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TrumpButton(
              text: "登录",
              textColor: Colors.white,
              height: 32,
              width: 64,
              backgroundColor: Colors.blue,
              borderStyle: BorderStyle.none,
              onTap: () {
                context.pushNamed("login");
              },
            ),
            const SizedBox(width: 32),
            TrumpButton(
              text: "注册",
              textColor: Colors.white,
              width: 64,
              height: 32,
              backgroundColor: Colors.red,
              borderStyle: BorderStyle.none,
              onTap: () => context.pushNamed("register"),
            ),
          ],
        ),
      ),
    );
  }
}

class _MineInfoPanel extends StatelessWidget {
  const _MineInfoPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
            child: Consumer<CurrentUserViewModel>(
              builder: (context, vm, child) {
                return GestureDetector(
                    onTap: () {
                      context.pushNamed(
                        "user_detail",
                        pathParameters: {"id": vm.user!.id.toString()},
                      );
                    },
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            UserAvatar(
                              url: vm.user?.avatarUrl ?? '',
                              size: 64,
                              radius: 4,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        vm.user?.name ?? '',
                                        //todo:note: 设置height才让文字和图标看起来水平居中。
                                        style: const TextStyle(
                                            fontSize: 18, height: 1.7),
                                      ),
                                      Container(
                                        width: 14,
                                        height: 14,
                                        margin: const EdgeInsets.only(left: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                        child: const Icon(Icons.male,
                                            size: 13, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  //SizedBox(height: 4),
                                  Text("ID:${vm.user?.id ?? 0}  人气:0",
                                      style: TrumpCommon.greyText),
                                ],
                              ),
                            ),
                            const Spacer(),
                            const TextButton(
                              onPressed: null,
                              child: Text(
                                "去主页",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        vm.user == null
                            ? const SizedBox()
                            : _InfoWithCount(user: vm.user!), // 粉丝数量、关注量、好友量
                        const SizedBox(height: 32),
                      ],
                    ));
              },
            ),
          ),
          const _LevelIndicator(),
        ],
      ),
    );
  }
}

class _InfoWithCount extends StatelessWidget {
  final User? user;
  const _InfoWithCount({
    super.key,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentUserViewModel>(builder: (context, curUser, _) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _TapItem(
            text: "粉丝",
            count: user?.fanCount ?? 0,
            onTap: () => context.pushNamed("fans", queryParameters: {
              "is_fan": "false",
              "id": user!.id.toString()
            }).then((_) {
              curUser.getProfile();
            }),
          ),
          _TapItem(
            text: "关注",
            count: user?.followingUserCount ?? 0,
            onTap: () => context.pushNamed(
              "fans",
              queryParameters: {"is_fan": "true", "id": user!.id.toString()},
            ).then((_) {
              curUser.getProfile();
            }),
          ),
          _TapItem(
            text: "好友",
            count: user?.friendCount ?? 0,
            onTap: () => context.pushNamed("contacts").then((_) {
              curUser.getProfile();
            }),
          ),
        ],
      );
    });
  }
}

class _LevelIndicator extends StatelessWidget {
  const _LevelIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Row(
        children: [
          Consumer<CurrentUserViewModel>(builder: (context, vm, child) {
            return Container(
              alignment: Alignment.bottomRight,
              width: width * (vm.user?.progress ?? 0) / 100 > 40
                  ? width * (vm.user?.progress ?? 0) / 100
                  : 40,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 3, color: Colors.red),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                color: Colors.red,
                child: Text(
                  "LV.${vm.user?.level ?? 0}",
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            );
          }),
          const Spacer(),
        ],
      ),
    );
  }
}

class _TapItem extends StatelessWidget {
  final String text;
  final int count;
  final VoidCallback onTap;
  const _TapItem(
      {required this.text, required this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            text,
            style: const TextStyle(color: Colors.grey),
          ),
          Text(
            "$count",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class MenuListItem extends StatelessWidget {
  final MineMenuItem menu;
  const MenuListItem({
    super.key,
    required this.menu,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(menu.pathName),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(menu.topRadius ? 8 : 0),
            bottom: Radius.circular(menu.bottomRadius ? 8 : 0),
          ),
        ),
        child: Row(
          children: [
            const Icon(color: Colors.grey, Icons.home),
            const SizedBox(width: 8),
            Text(
              menu.text,
              style: const TextStyle(fontSize: 20),
            ),
            const Spacer(),
            menu.hintText == ""
                ? const Icon(Icons.chevron_right, color: Colors.grey)
                : Text(menu.hintText),
          ],
        ),
      ),
    );
  }
}

List<MineMenuItem?> mineMenus = [
  null,
  MineMenuItem(
    text: "我的帐户",
    pathName: "my_account",
    icon: (Icons.home),
    topRadius: true,
  ),
  MineMenuItem(
    text: "我的收藏",
    pathName: "my_collections",
    icon: (Icons.home),
  ),
  MineMenuItem(
    text: "邀请好友",
    pathName: "invite_friends",
    icon: (Icons.home),
    bottomRadius: true,
  ),
  null,
  MineMenuItem(
    text: "勋章",
    pathName: "my_medals",
    icon: (Icons.home),
    topRadius: true,
  ),
  MineMenuItem(
    text: "纪念卡",
    pathName: "my_annversary_cards",
    icon: (Icons.home),
  ),
  MineMenuItem(
    text: "荧光棒",
    pathName: "light_stick",
    icon: (Icons.home),
    bottomRadius: true,
  ),
  null,
  MineMenuItem(
    text: "意见反馈",
    pathName: "my_feedback",
    icon: (Icons.home),
    topRadius: true,
  ),
  MineMenuItem(
    text: "帮助中心",
    pathName: "help_center",
    icon: (Icons.home),
  ),
  MineMenuItem(
    text: "个人资料",
    pathName: "my_profile",
    icon: (Icons.home),
    hintText: "完善资料得福利",
  ),
  MineMenuItem(
    text: "设置",
    pathName: "my_settings",
    icon: (Icons.home),
    bottomRadius: true,
  ),
];

class MineMenuItem {
  final String pathName;
  final String text;
  final IconData icon;
  final bool topRadius;
  final bool bottomRadius;
  final String hintText;

  MineMenuItem({
    required this.text,
    required this.pathName,
    required this.icon,
    this.topRadius = false,
    this.bottomRadius = false,
    this.hintText = "",
  });
}
