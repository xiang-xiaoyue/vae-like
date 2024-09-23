// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/app_bar.dart';
import 'package:trump/components/divider.dart';
import 'package:trump/pages/mine/sub/setting/sub/preference/vm.dart';

//偏好设置
class PreferencePage extends StatelessWidget {
  const PreferencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserPreferenceViewModel>(
      create: (context) => UserPreferenceViewModel(),
      child: Consumer<UserPreferenceViewModel>(
          child: const Text(
            "点击会跳转到手机设置-通知页面内，可在手机的“设置”-“通知”功能中，找到应用程序“TrumpChat”进行更改",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          builder: (context, vm, child) {
            return Scaffold(
              appBar: CommonAppBar(
                title: "偏好设置",
                rightPadding: 0,
                actions: [
                  TextButton(
                    onPressed: () {
                      vm.updatePreference().then((success) {
                        if (success == true) {
                          context.pop();
                        }
                      });
                    },
                    child: const Text(
                      "提交",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: child,
                  ),
                  vm.up != null
                      ? Expanded(
                          child: ListView.separated(
                            itemBuilder: (ctx, idx) {
                              return _getItem(vm, _list[idx]);
                            },
                            separatorBuilder: (ctx, idx) {
                              return const CustomDivider();
                            },
                            itemCount: _list.length,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            );
          }),
    );
  }
}

List<String> _list = [
  "评论消息提醒",
  "官方消息提醒",
  "@我消息提醒",
  "聊天消息提醒",
  "新粉丝通知",
  "打开城市定位",
];
//   //  "喂消息提醒"
//   //  "索求纪念卡消息提醒"
_Item _getItem(UserPreferenceViewModel vm, String label) {
  switch (label) {
    case "评论消息提醒":
      return _Item(
        label: label,
        onChange: (v) {
          vm.up!.remindCommentNotice = !vm.up!.remindCommentNotice;
        },
        isSelected: vm.up!.remindCommentNotice,
      );
    case "官方消息提醒":
      return _Item(
        label: label,
        onChange: (v) {
          vm.up!.remindOfficialNotice = !vm.up!.remindOfficialNotice;
        },
        isSelected: vm.up!.remindOfficialNotice,
      );
    case "@我消息提醒":
      return _Item(
        label: label,
        onChange: (v) {
          vm.up!.remindAtMe = !vm.up!.remindAtMe;
        },
        isSelected: vm.up!.remindAtMe,
      );
    case "聊天消息提醒":
      return _Item(
        label: label,
        onChange: (v) {
          vm.up!.remindChatNotice = !vm.up!.remindChatNotice;
        },
        isSelected: vm.up!.remindChatNotice,
      );
    case "新粉丝通知":
      return _Item(
        label: label,
        onChange: (v) {
          vm.up!.newFan = !vm.up!.newFan;
        },
        isSelected: vm.up!.newFan,
      );
    case "打开城市定位":
      return _Item(
        label: label,
        onChange: (v) {
          vm.up!.openLocation = !vm.up!.openLocation;
        },
        isSelected: vm.up!.openLocation,
      );
  }
  return _Item(
    label: "未知选项",
    onChange: () {},
    isSelected: false,
  );
}

class _Item extends StatefulWidget {
  final String label;
  final Function onChange;
  final bool isSelected;
  const _Item({
    super.key,
    required this.label,
    required this.onChange,
    required this.isSelected,
  });

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  bool isSelected = false;
  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: ListTile(
        leading: Text(
          widget.label,
          style: const TextStyle(fontSize: 18),
        ),
        trailing: Switch(
          value: isSelected,
          onChanged: (v) {
            widget.onChange(v);
            setState(() => isSelected = v);
          },
          inactiveThumbColor: Colors.white,
          activeTrackColor: Colors.blue,
          inactiveTrackColor: Colors.grey[400],
        ),
        //selectedColor: Colors.red,
      ),
    );
  }
}
