import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/app_bar.dart';
import 'package:trump/components/avatar.dart';
import 'package:trump/components/index.dart';
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/pages/mine/sub/setting/sub/blacklist/vm.dart';
import 'package:trump/pages/mine/vm.dart';

class BlacklistPage extends StatelessWidget {
  const BlacklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentUserViewModel>(builder: (context, curUser, _) {
      return ChangeNotifierProvider<BlacklistViewModel>(
        create: (context) => BlacklistViewModel(curUser.user?.id ?? 0),
        child: Scaffold(
          appBar: const CommonAppBar(title: "黑名单"),
          body: Consumer<BlacklistViewModel>(builder: (context, vm, _) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 32),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _Item(user: vm.users[index]);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 1);
                    },
                    itemCount: vm.users.length,
                  ),
                ],
              ),
            );
          }),
        ),
      );
    });
  }
}

class _Item extends StatelessWidget {
  final User user;
  const _Item({required this.user});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Consumer<BlacklistViewModel>(builder: (context, vm, _) {
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          leading: UserAvatar(url: user.avatarUrl, size: 48, radius: 4),
          title: Text(user.name),
          trailing: _Btn(remove: () {
            vm.removeFromBlacklist(user);
          }),
        );
      }),
    );
  }
}

class _Btn extends StatelessWidget {
  final Function remove;
  const _Btn({required this.remove});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showOptions(context).then((v) {
          if (v == 1) {
            print("remove-------------");
            // 移除
            remove();
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.blue[500],
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Text(
          "移除",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showOptions(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: const Text(
            "是否移出黑名单？",
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            CupertinoButton(
              child: const Text("取消"),
              onPressed: () => context.pop(0),
            ),
            CupertinoButton(
              child: const Text(
                "移出",
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () => context.pop(1),
            ),
          ],
        );
      },
    );
  }
}
