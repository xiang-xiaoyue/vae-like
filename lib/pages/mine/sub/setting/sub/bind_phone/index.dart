import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/pages/mine/sub/setting/sub/bind_phone/vm.dart';

import '../../components/input.dart';

class BindPhonePage extends StatelessWidget {
  const BindPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BindPhoneViewModel>(
      create: (context) => BindPhoneViewModel(),
      child: Scaffold(
        appBar: const CommonAppBar(title: "绑定新手机"),
        body: Consumer<BindPhoneViewModel>(builder: (context, vm, _) {
          return Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(32),
            height: 300,
            child: Column(
              children: [
                ItemForBind(text: "中国", onChange: (v) => vm.Phone = v),
                ItemForBind(
                    text: "获取验证码",
                    isReverse: true,
                    onChange: (v) => vm.code = v),
                TrumpButton(
                  text: "确认绑定",
                  backgroundColor: Colors.grey.shade400,
                  textColor: Colors.white,
                  borderStyle: BorderStyle.none,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  onTap: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("未实现")));
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
