import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/search/app_bar.dart';
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/pages/publish/sub/post/sub/vm.dart';
import 'package:trump/pages/search/components/user_item.dart';

// 发布帖子时选择@谁
class SelectAtUserPage extends StatelessWidget {
  const SelectAtUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SelectAtUserViewModel>(
      create: (context) => SelectAtUserViewModel(),
      child: Scaffold(
        body: Consumer<SelectAtUserViewModel>(builder: (context, vm, child) {
          return SafeArea(
            child: Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.only(top: 114),
                  shrinkWrap: true,
                  itemBuilder: (ctx, idx) {
                    return SearchUserItem(
                      showRight: false,
                      leftOnTap: () => context.pop<User>(vm.users[idx]),
                      user: vm.users[idx],
                    );
                  },
                  itemCount: vm.users.length,
                ),
                SearchAppBar(
                  onSubmit: (kw) => vm.getUserList(kw),
                  text: "选择@谁",
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
