//寻找好友(用户)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/pages/notice/export.dart';
import 'package:trump/pages/search/components/input_app_bar.dart';
import 'package:trump/pages/search/components/user_item.dart';
import 'package:trump/pages/search/sub/user/vm.dart';

// 搜索用户,输入用户id或用户名关键字,有些数字可能既是id,又是用户名的关键字
class SearchUserPage extends StatefulWidget {
  const SearchUserPage({super.key});

  @override
  State<SearchUserPage> createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ChangeNotifierProvider<SearchUserViewModel>(
          create: (contxt) => SearchUserViewModel(),
          child: Consumer<SearchUserViewModel>(builder: (context, vm, child) {
            return Stack(
              children: [
                vm.keyword.trim() == ''
                    ? const _DefaultDisplay()
                    : const _QueryUserList(),
                // 顶部搜索框与按钮
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: TrumpSize.appBarHeight,
                  child: InputAppBar(),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}

// 根据关键字，返回用户列表
class _QueryUserList extends StatelessWidget {
  const _QueryUserList();

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchUserViewModel>(
      builder: (context, vm, child) {
        return vm.userCount == 0
            ? const Center(child: NoMore())
            : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.only(top: TrumpSize.appBarHeight),
                itemCount: vm.userCount,
                itemBuilder: (context, index) {
                  return SearchUserItem(user: vm.userList[index]);
                },
              );
      },
    );
  }
}

class _DefaultDisplay extends StatelessWidget {
  const _DefaultDisplay();
  /* todo: 推荐的用户列表，每次刷新不一样。
            const _BtnItem(text: "推荐", child: Text("")),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 30,
              itemBuilder: (context, index) {
                return Text("hello");
              },
            ),
           */

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _BtnItem(text: "我的ID", child: Text("1")),
        _BtnItem(text: "附近的人", child: Icon(Icons.chevron_right)),
        SizedBox(height: 4),
      ],
    );
  }
}

class _BtnItem extends StatelessWidget {
  final String text;
  final Widget child;
  const _BtnItem({required this.text, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          "search",
          queryParameters: {"type": "nearby"},
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        color: Colors.white,
        height: 52,
        child: Row(
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const Spacer(),
            child,
          ],
        ),
      ),
    );
  }
}
