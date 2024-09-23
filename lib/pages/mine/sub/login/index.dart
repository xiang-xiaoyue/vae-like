import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/buttons/button.dart';
import 'package:trump/components/toast.dart';
import 'package:trump/pages/mine/component/text_field.dart';
import 'package:trump/pages/mine/vm.dart';

// 登录页面
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child:
                Consumer<CurrentUserViewModel>(builder: (context, vm, child) {
              return Column(
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/app_logo.png",
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AuthTextField(
                    hintText: "邮箱",
                    onChange: (v) {
                      vm.loginEmail = v.trim();
                      vm.notify();
                    },
                  ),
                  const SizedBox(height: 10),
                  AuthTextField(
                    obscureText: true,
                    hintText: "密码",
                    onChange: (v) {
                      vm.loginPassword = v.trim();
                      vm.notify();
                    },
                  ),
                  const SizedBox(height: 10),
                  TrumpButton(
                    text: "登录",
                    textColor: Colors.white,
                    backgroundColor: (vm.loginEmail.isNotEmpty &&
                            vm.loginPassword.isNotEmpty)
                        ? Colors.blue
                        : Colors.grey.shade500,
                    borderStyle: BorderStyle.none,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    onTap: () {
                      if (vm.loginPassword.isEmpty ||
                          vm.loginPassword.isEmpty) {
                        context.showToast("信息填写完整后才可登录");
                        return;
                      }
                      vm.login().then((res) {
                        if (res == true) {
                          context.showToast("登录成功");
                          context.pushNamed("mine");
                        } else {
                          context.showToast("登录失败");
                        }
                      });
                    },
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => context.pushNamed("register"),
                        child: const Text(
                          "注册账号",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      const TextButton(
                        onPressed: null,
                        child: Text(
                          "忘记密码(暂不支持)",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
