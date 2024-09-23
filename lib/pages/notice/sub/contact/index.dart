//联系人页面
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/pages/mine/vm.dart';
import 'package:trump/pages/notice/components/go_back_leading.dart';
import 'package:trump/pages/notice/sub/contact/vm.dart';
import 'package:trump/pages/search/components/user_item.dart';

// 好友与群组查询
class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ChangeNotifierProvider<ContactViewModel>(
          create: (context) => ContactViewModel(),
          child: const Stack(
            children: [
              Positioned(child: _Page()),
              MsgGoBackLeading(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TwoTabAppBar(
            leftText: "好友",
            rightText: "群组",
          ),
          Expanded(
            child: Consumer<ContactViewModel>(builder: (context, vm, child) {
              return Consumer<CurrentUserViewModel>(
                  builder: (context, curUser, _) {
                return TabBarView(
                  children: [
                    Stack(
                      children: [
                        ListView.builder(
                          padding: const EdgeInsets.only(top: 52),
                          itemBuilder: (ctx, idx) {
                            return SearchUserItem(
                              user: vm.kw.isNotEmpty
                                  ? vm.users[idx]
                                  : vm.friends[idx],
                              rightOnTap: () {
                                vm.addFriend(vm.users[idx]);
                                curUser.getProfile();
                              },
                            );
                          },
                          itemCount: vm.kw.isNotEmpty
                              ? vm.users.length
                              : vm.friends.length,
                        ),
                        Positioned(
                          height: 52,
                          top: 0,
                          left: 16,
                          right: 16,
                          child: CommonSearchTextField(
                            hintText: "",
                            onChange: (v) => vm.getUserList(v),
                          ),
                        ),
                      ],
                    ),
                    vm.filteredGroups.isEmpty
                        ? Center(
                            child: TextButton(
                              child: const Text("还没有群组，点击寻找群组"),
                              onPressed: () {
                                context.pushNamed("search",
                                    queryParameters: {"type": "group"});
                              },
                            ),
                          )
                        : Stack(
                            children: [
                              ListView.builder(
                                padding: const EdgeInsets.only(top: 52),
                                itemBuilder: (ctx, idx) =>
                                    SearchGroupItem(gs: vm.filteredGroups[idx]),
                                itemCount: vm.filteredGroups.length,
                              ),
                              Positioned(
                                height: 52,
                                top: 0,
                                left: 16,
                                right: 16,
                                child: CommonSearchTextField(
                                  hintText: "",
                                  onChange: (v) => vm.filterGroups(v),
                                ),
                              ),
                            ],
                          ),
                  ],
                );
              });
            }),
          ),
        ],
      ),
    );
  }
}
