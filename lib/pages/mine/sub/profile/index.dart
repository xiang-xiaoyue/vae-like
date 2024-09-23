// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/app_bar.dart';
import 'package:trump/components/avatar.dart';
import 'package:trump/components/buttons/button.dart';
import 'package:trump/pages/mine/vm.dart';
import 'package:trump/util/util.dart';

// 个人资料页面
// todo:不同的Item,要弹出不同的东西，有dialog,有bottomsheet,难以处理，所以等 等。
class MineProfilePage extends StatelessWidget {
  const MineProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appBar = const CommonAppBar(title: "修改资料", rightPadding: 0);
    return Scaffold(
      appBar: appBar,
      body: Consumer<CurrentUserViewModel>(builder: (context, vm, child) {
        return StatefulBuilder(builder: (context, ss) {
          return ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              //const _Banner(),
              _Item(
                text: "头像",
                sub: UserAvatar(url: vm.user!.avatarUrl, size: 64),
                onTap: () {
                  uploadSingleSelectedFile().then((url) {
                    vm.user!.avatarUrl = url;
                    vm.updateCurrentUser();
                  });
                },
              ),
              _ProfileNameItem(vm: vm),
              const SizedBox(height: 2),
              _ProfileGenderItem(vm: vm),
              const _ProfileBirthdayItem(),
              //const _Item(text: "城市", sub: Text("浙江 杭州")),
              const SizedBox(height: 2),
              _Item(
                text: "修改签名",
                sub: Text(
                  (vm.user!.sign.length <= 10
                      ? vm.user!.sign
                      : "${vm.user!.sign.substring(0, 10)}..."),
                  style: const TextStyle(color: Colors.blue),
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  context.pushNamed(
                    "update_sign",
                    queryParameters: {"sign": vm.user!.sign},
                  );
                },
              ),
            ],
          );
        });
      }),
    );
  }
}

// 生日
class _ProfileBirthdayItem extends StatefulWidget {
  const _ProfileBirthdayItem({super.key});

  @override
  State<_ProfileBirthdayItem> createState() => _ProfileBirthdayItemState();
}

class _ProfileBirthdayItemState extends State<_ProfileBirthdayItem> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentUserViewModel>(builder: (context, vm, _) {
      return _Item(
        text: "生日",
        sub: Text(absoluteTime(vm.user!.birthday, onlyDate: true)),
        onTap: () {
          showBottomSheet(
              context: context,
              builder: (context) {
                return CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1970, 1, 1),
                    lastDate: DateTime(2030, 1, 1),
                    currentDate:
                        DateTime.fromMillisecondsSinceEpoch(vm.user!.birthday),
                    onDateChanged: (v) {
                      vm.setBirthday(v.millisecondsSinceEpoch);
                      vm.updateCurrentUser().then((_) {
                        context.pop();
                      });
                    });
              });
        },
      );
    });
  }
}

// 性别
class _ProfileGenderItem extends StatefulWidget {
  final CurrentUserViewModel vm;
  const _ProfileGenderItem({
    super.key,
    required this.vm,
  });

  @override
  State<_ProfileGenderItem> createState() => _ProfileGenderItemState();
}

class _ProfileGenderItemState extends State<_ProfileGenderItem> {
  Future<dynamic> _showGenderOptionList(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          children: ['male', 'female', 'secret'].map((item) {
            return SimpleDialogOption(
              padding: const EdgeInsets.all(16),
              onPressed: () {
                context.pop(item);
              },
              child: _displayGender(item),
            );
          }).toList(),
        );
      },
    );
  }

  late String genderStr;
  @override
  void initState() {
    super.initState();
    genderStr = widget.vm.user!.gender ?? 'secret';
  }

  @override
  Widget build(BuildContext context) {
    return _Item(
        text: "性别",
        sub: _displayGender(genderStr),
        onTap: () {
          _showGenderOptionList(context).then((v) {
            setState(() => genderStr = v);
            widget.vm.user!.gender = v;
            widget.vm.updateCurrentUser();
          });
        });
  }
}

// 用户名
class _ProfileNameItem extends StatelessWidget {
  final CurrentUserViewModel vm;
  const _ProfileNameItem({
    super.key,
    required this.vm,
  });
  Row _buildDialogFooter(BuildContext context, String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TrumpButton(
          onTap: () => context.pop(),
          text: "取消",
          width: 120,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
        ),
        TrumpButton(
          onTap: () {
            var v = context.pushReplacementNamed("update_name",
                queryParameters: {"current_name": name});
            // v.then((res) {
            //   print("returnvalue: ${res.toString()}");
            //   context.pop();
            // });
            return;
          },
          text: "确定",
          width: 120,
          textColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _Item(
      text: "用户名",
      sub: Text(vm.user!.name),
      onTap: () {
        showDialog(
            context: context,
            builder: (ctx) {
              return Dialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                      child: Text(
                        "用户名只能修改1次，确定要修改吗?",
                        softWrap: true,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 0.5, color: Colors.grey),
                        ),
                      ),
                      child: _buildDialogFooter(ctx, vm.user!.name),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }
}

// 顶部提示
class _Banner extends StatefulWidget {
  const _Banner();

  @override
  State<_Banner> createState() => _BannerState();
}

class _BannerState extends State<_Banner> {
  bool hasGet = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.blue[600],
      ),
      child: Consumer<CurrentUserViewModel>(builder: (context, vm, child) {
        return Row(
          children: [
            Text(
              "完善资料得到福利 进度80%",
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 80,
              height: 60,
              child: TrumpButton(
                padding: const EdgeInsets.all(0),
                text: "领取${hasGet == true ? '成功' : ''}",
                textColor: Colors.blue,
                onTap: () {
                  hasGet = true;
                  setState(() {});
                },
              ),
            )
          ],
        );
      }),
    );
  }
}

// todo: item或许可提出为公共组件
class _Item extends StatelessWidget {
  final String text;
  final Widget sub;
  final VoidCallback? onTap;
  const _Item({required this.text, required this.sub, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: () => _showUpdateDialog(context),
      onTap: onTap,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 20),
            ),
            const Spacer(),
            LayoutBuilder(
              builder: (context, cs) {
                return DefaultTextStyle(
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  child: sub,
                );
              },
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  /*
  Future<dynamic> _showUpdateDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          //note: 给弹出的dislog设置borderRadius
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          // note: 默认弹出的dialog长度过长，可用singleChildScrollView套住。
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 300,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const Text(
                        textAlign: TextAlign.center,
                        "昵称只能修改一次，确定要修改吗？",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("取消"),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              print(context.widget.toString());
              //todo: context是dialog的上下文，要想办法得到资料页面的上下文，把弹窗替换成修改昵称页面。
        // 让资料页面成为修改昵称页面的上一级。
                              Navigator.of(context)
                                  .push(
                                MaterialPageRoute(
                                  builder: (context) => const UpdateNamePage(
                                      currentName: "项小月xxx"),
                                ),
                              )
                                  .then((res) {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(
                                    SnackBar(
                                      content: Text("$res"),
                                    ),
                                  );
                              });
                            },
                            child: const Text(
                              "确定",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.all(16),
        );
      },
    );
  }
*/
}

// male->返回"男",传入其他性别同理。
Text _displayGender(String gender, {double fontSize = 18}) {
  var style = TextStyle(fontSize: fontSize);
  switch (gender) {
    case "male":
      return Text("男", style: style);
    case "female":
      return Text("女", style: style);
    default:
      return Text("保密", style: style);
  }
}
