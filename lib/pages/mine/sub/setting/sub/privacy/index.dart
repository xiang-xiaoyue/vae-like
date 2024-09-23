import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/app_bar.dart';
import 'package:trump/components/buttons/button.dart';
import 'package:trump/components/divider.dart';
import 'package:trump/pages/mine/sub/setting/sub/privacy/vm.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserPrivacyViewModel>(
      create: (context) => UserPrivacyViewModel(),
      child: Scaffold(
        appBar: const CommonAppBar(title: "隐私设置"),
        body: SingleChildScrollView(
          child: Consumer<UserPrivacyViewModel>(builder: (context, vm, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Text(
                    "以下设置均针对“个人主页”进行隐私设置",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  children: vm.up != null
                      ? [
                          _Item(
                              label: "谁能看我的帖子",
                              value: vm.up!.visitThread,
                              onSelect: (v) => vm.up!.visitThread = v),
                          const CustomDivider(),
                          _Item(
                              label: "谁能给我私信",
                              value: vm.up!.sendPrivateMsgToMe,
                              onSelect: (v) => vm.up!.sendPrivateMsgToMe = v),
                          const CustomDivider(),
                          _Item(
                              label: "谁能看我的关注和粉丝",
                              value: vm.up!.visitFollowingAndFans,
                              onSelect: (v) =>
                                  vm.up!.visitFollowingAndFans = v),
                          const CustomDivider(),
                          _Item(
                              label: "谁能看与我的距离",
                              value: vm.up!.visitDistanceFromMe,
                              onSelect: (v) => vm.up!.visitDistanceFromMe = v),
                          const CustomDivider(),
                          _Item(
                              label: "谁能看我的最近登录时间",
                              value: vm.up!.visitMyLastLoginTime,
                              onSelect: (v) => vm.up!.visitMyLastLoginTime = v),
                        ]
                      : [],
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                    child: TrumpButton(
                      height: 55,
                      text: "保存设置",
                      textSize: 18,
                      textColor: Colors.white,
                      backgroundColor: Colors.blue,
                      onTap: () => vm.updatePrivacy().then((success) {
                        if (success == true) {
                          context.pop();
                        }
                      }),
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}

Map<String, String> _maps = {
  "所有人": "all-user",
  "好友": "friends",
  "仅自己": "only-self",
};

class _Item extends StatefulWidget {
  final String label;
  final Function onSelect;
  final String value;
  const _Item({
    required this.label,
    required this.onSelect,
    required this.value,
  });

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  String text = "所有人";
  @override
  void initState() {
    super.initState();
    switch (widget.value) {
      case "all-user":
        text = "所有人";
        break;
      case "only-self":
        text = "仅自己";
        break;
      case "friends":
        text = "好友";
        break;
      default:
        text = "未知选项";
        break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: ListTile(
        title: Text(
          widget.label,
          style: const TextStyle(fontSize: 18),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        trailing: TextButton.icon(
          iconAlignment: IconAlignment.end,
          style: const ButtonStyle(
            textStyle: WidgetStatePropertyAll(
              TextStyle(fontSize: 16),
            ),
            padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
          ),
          icon: Icon(Icons.chevron_right, color: Colors.grey[700]),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => buildDialog(context),
          ).then(
            (res) => setState(() {
              print("返回内容：$res");
              setState(() {});
              text = res;
              widget.onSelect(_maps[res]);
            }),
          ),
          label: Text(
            text,
            style: TextStyle(color: Colors.grey[700], fontSize: 16),
          ),
        ),
      ),
    );
  }
}

Widget buildDialog(BuildContext context) {
  return SimpleDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    backgroundColor: Colors.white,
    children: [
      SimpleDialogOption(
        child: const Text("所有人"),
        onPressed: () {
          Navigator.of(context).pop("所有人");
        },
      ),
      SimpleDialogOption(
        child: const Text("好友"),
        onPressed: () {
          Navigator.of(context).pop("好友");
        },
      ),
      SimpleDialogOption(
        child: const Text("仅自己"),
        onPressed: () {
          Navigator.of(context).pop("仅自己");
        },
      ),
    ],
  );
}
