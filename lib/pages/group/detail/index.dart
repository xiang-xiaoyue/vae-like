import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/pages/group/detail/vm.dart';
import 'package:trump/util/util.dart';

BoxDecoration _decoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(8),
);

// 群组的详情页
class GroupDetailPage extends StatelessWidget {
  final String id;
  const GroupDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "群组信息"),
      body: SingleChildScrollView(
        child: ChangeNotifierProvider<GroupDetailViewModel>(
          create: (context) => GroupDetailViewModel(id),
          child: Consumer<GroupDetailViewModel>(builder: (context, vm, _) {
            return Column(
              children: vm.group == null
                  ? []
                  : [
                      const _GroupHeader(),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        decoration: _decoration,
                        child: Column(
                          children: [
                            if (vm.group != null)
                              _MenuItem(
                                text: "群主/管理员",
                                pathName: "group_admin_list",
                                rightChild: Row(
                                  children: [
                                    _GroupMemberAvatar(
                                        avatar: vm.group?.user.avatarUrl ?? ''),
                                    if (vm.group?.wardenList != null &&
                                        vm.group?.wardenList![0] != null)
                                      _GroupMemberAvatar(
                                          avatar: vm.group?.wardenList![0]
                                                  .avatarUrl ??
                                              ''),
                                    if (vm.group?.wardenList![1] != null &&
                                        vm.group?.wardenList != null)
                                      _GroupMemberAvatar(
                                        avatar: vm.group?.wardenList![1]
                                                .avatarUrl ??
                                            '',
                                      ),
                                  ],
                                ),
                              ),
                            if (vm.group != null && vm.group!.members != null)
                              _MenuItem(
                                text: "群成员",
                                pathName: "group_member_list",
                                rightChild: Row(
                                  children: [
                                    if (vm.group?.members != null &&
                                        vm.group!.members!.length > 0 &&
                                        vm.group?.members![0] != null)
                                      _GroupMemberAvatar(
                                          avatar:
                                              vm.group?.members![0].avatarUrl ??
                                                  ''),
                                    if (vm.group?.members != null &&
                                        vm.group!.members!.length > 1 &&
                                        vm.group?.members![1] != null)
                                      _GroupMemberAvatar(
                                          avatar:
                                              vm.group?.members![1].avatarUrl ??
                                                  ''),
                                    if (vm.group?.members != null &&
                                        vm.group!.members!.length > 2 &&
                                        vm.group?.members![2] != null)
                                      _GroupMemberAvatar(
                                          avatar:
                                              vm.group?.members![2].avatarUrl ??
                                                  ''),
                                  ],
                                ),
                              ),
                            _MenuItem(
                              rightChild: Text(
                                  "${vm.group?.memberCount}/${vm.group?.capacity}"),
                              text: "群人数",
                            ),
                            _MenuItem(
                              rightChild: Text(absoluteTime(
                                  vm.group?.createTime ?? 0,
                                  onlyDate: true)),
                              text: "群成员",
                            ),
                          ],
                        ),
                      ),
                      _ExtraInfo(
                          title: "群公告", subTitle: vm.group?.bulletin ?? '无公告'),
                      _ExtraInfo(
                          title: "群简介", subTitle: vm.group?.brief ?? "无简介"),
                      if (vm.group != null && vm.group!.inGroup == true)
                        TrumpButton(
                          text: "发起会话",
                          textSize: 20,
                          textColor: Colors.white,
                          backgroundColor: Colors.blue,
                          borderRadius: 8,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          onTap: () {
                            context.pushNamed("group_chat", pathParameters: {
                              "id": vm.group!.id.toString()
                            });
                          },
                        ),
                      if (vm.group != null)
                        TrumpButton(
                          text: (vm.group!.inGroup) ? "退出群组" : "加入群组",
                          textSize: 20,
                          textColor: Colors.white,
                          backgroundColor:
                              (vm.group!.inGroup) ? Colors.red : Colors.blue,
                          borderRadius: 8,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          onTap: () {
                            vm.toggleInGroup().then((success) {
                              if (success == true) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("操作成功"),
                                  duration: Duration(milliseconds: 300),
                                ));
                              }
                            });
                          },
                        ),
                    ],
            );
          }),
        ),
      ),
    );
  }
}

class _ExtraInfo extends StatelessWidget {
  final String title;
  final String subTitle;
  const _ExtraInfo({
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: _decoration,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                    // overflow: TextOverflow.ellipsis,
                  ),
                  // maxLines: 2,
                  maxLines: null,
                  //softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GroupHeader extends StatelessWidget {
  const _GroupHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: _decoration,
      child: Consumer<GroupDetailViewModel>(builder: (context, vm, _) {
        return Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vm.group?.name ?? '群无名',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "群号:${vm.group?.id}",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Spacer(),
            UserAvatar(url: vm.group?.cover ?? '', size: 64, radius: 8),
          ],
        );
      }),
    );
  }
}

class _GroupMemberAvatar extends StatelessWidget {
  final String avatar;
  const _GroupMemberAvatar({required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: UserAvatar(url: avatar, size: 48, radius: 4),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String text;
  final Widget rightChild;
  final String pathName;
  const _MenuItem({
    required this.rightChild,
    required this.text,
    this.pathName = "",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (pathName == "") {
        } else if (pathName == "group_admin_list" ||
            pathName == "group_member_list") {
          context.pushNamed(pathName, pathParameters: {"id": "6"});
        } else {
          //todo: 多处showDialog,只为显示简单的提示，可提取出来。
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 100,
                  color: Colors.white,
                  child: const Text("路径错误"),
                ),
              );
            },
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            rightChild,
            //Icon有内边距，难以去除（不是IconButton,是Icon），只好暂时忽略它，好在忽略也没事。
          ],
        ),
      ),
    );
  }
}
