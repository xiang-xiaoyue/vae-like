import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/app_bar.dart';
import 'package:trump/components/button.dart';
import 'package:trump/components/index.dart';
import 'package:trump/components/input.dart';
import 'package:trump/pages/mine/vm.dart';
import 'package:trump/service/save.dart';
import 'package:trump/vm.dart';

class UpdatePwdPage extends StatelessWidget {
  const UpdatePwdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CommonAppBar(title: "修改密码"),
      body: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    super.key,
  });

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  // TextEditingController prePwdController = TextEditingController();
  // TextEditingController newPwdController = TextEditingController();
  // TextEditingController repeatPwdController = TextEditingController();
  TextEditingController controller = TextEditingController();
  String newPwd = '';
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      newPwd = controller.text.trim();
      if (newPwd.length < 6 || newPwd.length > 18) {
        showTip = true;
      } else {
        showTip = false;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool showTip = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      children: [
        // _Item(
        //   child: InputFieldFilledWhite(
        //       hintText: "原密码", controller: prePwdController),
        // ),
        // _Item(
        //   child: InputFieldFilledWhite(
        //       hintText: "新密码", controller: newPwdController),
        // ),
        // _Item(
        //   child: InputFieldFilledWhite(
        //       hintText: "确认新密码", controller: repeatPwdController),
        // ),
        _Item(
          child:
              InputFieldFilledWhite(controller: controller, hintText: "输入新密码"),
        ),
        Consumer2<CurrentUserViewModel, GlobalViewModel>(
          builder: (context, vm, global, child) {
            return TrumpButton(
              text: "确认修改",
              textColor: Colors.white,
              // backgroundColor: (newPwd.length < 6 || newPwd.length > 18)
              //     ? Colors.grey.shade500
              //     : Colors.blue,
              backgroundColor: Colors.orange,
              onTap: (newPwd.length < 6 || newPwd.length > 18)
                  ? null
                  : () {
                      vm.user!.password = newPwd;
                      vm.updatePwd().then((newToken) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text("成功")));
                        SaveService.writeString(newToken).then((v) {
                          global.setCurIdx(4);
                          context.pushNamed("index");
                        });
                      });
                    },
            );
          },
        ),
        const SizedBox(height: 4),
        showTip
            ? const Center(
                child: Text("密码长度6-18之间，你输入的密码太长或太短了",
                    style: TextStyle(color: Colors.red)))
            : const SizedBox(),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final Widget child;
  const _Item({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: child,
    );
  }
}
