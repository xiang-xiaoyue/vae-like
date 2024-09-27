import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/components/toast.dart';
import 'package:trump/pages/mine/component/text_field.dart';
import 'package:trump/pages/mine/sub/register/vm.dart';
import 'package:trump/pages/mine/vm.dart';

// 注册页面
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: CommonAppBar(title: "邮箱注册", backgrounColor: Colors.grey.shade200),
      body: ChangeNotifierProvider<RegisterViewModel>(
        create: (context) => RegisterViewModel(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          child: Consumer<RegisterViewModel>(builder: (context, vm, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthTextField(
                  onChange: (v) {
                    vm.registerData.email = v.trim();
                    vm.displayTipText();
                  },
                  hintText: "邮箱",
                ),
                const SizedBox(height: 10),
                AuthTextField(
                    onChange: (v) {
                      vm.registerData.name = v.trim();
                      vm.displayTipText();
                    },
                    hintText: "用户名"),
                const SizedBox(height: 10),
                AuthTextField(
                    obscureText: true,
                    onChange: (v) {
                      vm.registerData.password = v.trim();
                      vm.displayTipText();
                    },
                    hintText: "密码长度6到18之间"),
                const SizedBox(height: 10),
                AuthTextField(
                    obscureText: true,
                    onChange: (v) {
                      vm.registerData.repeatPassword = v.trim();
                      vm.displayTipText();
                    },
                    hintText: "重复输入密码"),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(vm.tipText, style: TextStyle(color: Colors.red)),
                ),
                Consumer<CurrentUserViewModel>(builder: (context, cur, _) {
                  return TrumpButton(
                    textSize: 18,
                    text: "完成注册!然后去完善资料",
                    borderStyle: BorderStyle.none,
                    backgroundColor: vm.isLoading == false
                        ? (vm.tipText == "" && vm.registerData.name.isNotEmpty)
                            ? Colors.blue
                            : Colors.grey.shade500
                        : Colors.grey,
                    onTap: () {
                      if (vm.isLoading == true) {
                        return null;
                      } else {
                        if (vm.registerData.name.isNotEmpty &&
                            vm.tipText == "") {
                          vm.register().then((success) {
                            if (success == true) {
                              cur.getProfile();
                              cur.setLoginStatus(true);
                              context.pushReplacementNamed("mine");
                            } else {
                              context.showToast(vm.tipText);
                              return;
                            }
                          });
                        } else {
                          context.showToast(vm.tipText);
                        }
                      }
                    },
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    textColor: Colors.white,
                  );
                }),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("我已同意并阅读过"),
                    TextButton(
                      onPressed: null,
                      style: ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.all(0))),
                      child: Text("《用户协议》"),
                    ),
                    TextButton(
                      onPressed: null,
                      style: ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.all(0))),
                      child: Text("隐私政策"),
                    ),
                  ],
                ),
                //const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "已有账号？",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    TextButton(
                      onPressed: () => context.pushNamed("login"),
                      child: const Text(
                        "点击登录",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
