import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/app_bar.dart';
import 'package:trump/components/buttons/button.dart';
import 'package:trump/pages/mine/sub/setting/components/input.dart';
import 'package:trump/pages/mine/sub/setting/sub/bind_email/vm.dart';

class BindEmailPage extends StatelessWidget {
  const BindEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BindEmailViewModel>(
      create: (context) => BindEmailViewModel(),
      child: Scaffold(
        appBar: const CommonAppBar(title: "绑定新手机"),
        body: Consumer<BindEmailViewModel>(builder: (context, vm, _) {
          return Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                //AuthTextField(onChange: (v) => vm.email = v, hintText: "邮箱"),
                ItemForBind(text: "邮箱", onChange: (v) => vm.email = v.trim()),
                GestureDetector(
                  onTap: () {
                    vm.getVeriCode();
                  },
                  child: ItemForBind(
                      text: vm.seconds <= 0 ? "验证码" : vm.seconds.toString(),
                      isReverse: true,
                      onChange: (v) {
                        vm.code = v.trim();
                      }),
                ),
                TrumpButton(
                  text: "确认绑定",
                  backgroundColor: Colors.grey.shade400,
                  textColor: Colors.white,
                  borderStyle: BorderStyle.none,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  onTap: () {
                    vm.validate().then((success) {
                      if (success == true) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("成功")));
                        context.pop(true);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("失败"), backgroundColor: Colors.red));
                      }
                    });
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
