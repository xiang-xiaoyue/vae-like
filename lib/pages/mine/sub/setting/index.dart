import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/app_bar.dart';
import 'package:trump/pages/mine/vm.dart';

// 个人设置界面
class MineSettingsPage extends StatelessWidget {
  const MineSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "设置"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 4, bottom: 64),
        child: Consumer<CurrentUserViewModel>(builder: (context, vm, _) {
          return Column(
            children: [
              _Item(
                  text: "绑定手机（暂不支持）",
                  isActive: true,
                  tipText: (vm.user?.phone).toString(),
                  pathName: "bind_phone"),
              _Item(
                isActive: true,
                text: "绑定邮箱",
                tipText: vm.user?.email ?? '',
                pathName: "bind_email",
              ),
              _Item(text: "绑定微博(暂不支持)", tipText: "未绑定"),
              _Item(isActive: true, text: "绑定QQ(暂不支持)", tipText: "已绑定"),
              _Item(isActive: true, text: "绑定微信(暂不支持)", tipText: "已绑定"),
              _Item(text: "绑定论坛(暂不支持)", tipText: "未绑定", hasBottom: false),

              const SizedBox(height: 4),
              _Item(text: "安全设置", pathName: "secure"),
              _Item(text: "收货地址管理", tipText: "", hasBottom: false),

              const SizedBox(height: 4),
              _Item(text: "偏好设置", tipText: "", pathName: "preference"),
              _Item(text: "隐私设置", tipText: "", pathName: "privacy"),
              _Item(
                  text: "黑名单",
                  tipText: "",
                  pathName: "blacklist",
                  hasBottom: false),
              const SizedBox(height: 4),

              _Item(text: "关于我们", tipText: "", pathName: "about_us"),
              _Item(
                  text: "意见反馈",
                  tipText: "",
                  pathName: "my_feedback",
                  hasBottom: false),
              _Item(text: "清除缓存", tipText: "178.90MB"),
              const SizedBox(height: 4),
              const _LogoutBtn(), //todo：封装按钮，像vue那样。
            ],
          );
        }),
      ),
    );
  }
}

class _LogoutBtn extends StatelessWidget {
  const _LogoutBtn();

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentUserViewModel>(builder: (context, vm, child) {
      return GestureDetector(
        onTap: () {
          vm.logout().then((success) {
            if (success) {
              context.pushNamed("home");
              return;
            } else {
              // todo:弹窗提示退出失败
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          color: Colors.white,
          alignment: Alignment.center,
          child: const Text(
            "退出当前账户",
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
            ),
          ),
        ),
      );
    });
  }
}

void show(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return const Dialog();
      });
}

class _Item extends StatelessWidget {
  String text;
  String tipText;
  bool isActive;
  String pathName;
  final bool hasBottom;
  _Item({
    this.hasBottom = true,
    this.tipText = "",
    required this.text,
    this.isActive = false,
    this.pathName = "",
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentUserViewModel>(builder: (context, vm, _) {
      return GestureDetector(
        onTap: () {
          context.pushNamed(pathName).then((success) {
            if (success == true) {
              vm.getProfile();
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: hasBottom
                  ? Border(
                      bottom: BorderSide(width: 1, color: Colors.grey[300]!),
                    )
                  : Border(),
            ),
            height: 64,
            child: Row(
              children: [
                Text(
                  text,
                  style: const TextStyle(fontSize: 20),
                ),
                const Spacer(),
                Text(
                  tipText,
                  style: TextStyle(
                    color: isActive ? Colors.blue[600] : Colors.grey[600],
                    fontSize: 18,
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _ClearCache extends StatelessWidget {
  String text;
  String tipText;
  bool isActive;
  String pathName;
  _ClearCache({
    this.tipText = "",
    required this.text,
    this.isActive = false,
    this.pathName = "",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              content: const Text(
                "确认要清除本地缓存？",
                style: TextStyle(fontSize: 20),
              ),
              actions: [
                CupertinoButton(
                    child: const Text("取消"),
                    onPressed: () {
                      Navigator.of(context).pop(0);
                    }),
                CupertinoButton(
                    child: const Text(
                      "清除",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(1);
                    }),
              ],
            );
          },
        );
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 64,
        child: Row(
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 20),
            ),
            const Spacer(),
            Text(
              tipText,
              style: TextStyle(
                color: isActive ? Colors.blue[600] : Colors.grey[600],
                fontSize: 18,
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
