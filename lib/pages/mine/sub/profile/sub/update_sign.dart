import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/app_bar.dart';
import 'package:trump/pages/mine/vm.dart';

// 修改签名页面
class UpdateSignPage extends StatelessWidget {
  final String sign;
  const UpdateSignPage({super.key, required this.sign});

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentUserViewModel>(builder: (context, vm, child) {
      return Scaffold(
        appBar: CommonAppBar(
          title: "个性签名",
          rightPadding: 0,
          actions: [
            TextButton(
              onPressed: () =>
                  vm.updateCurrentUser().then((v) => context.pop()),
              child: const Text("完成"),
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 4),
            _TextArea(
              sign: sign,
              onChange: (v) {
                vm.user!.sign = v;
              },
            ),
          ],
        ),
      );
    });
  }
}

class _TextArea extends StatefulWidget {
  final String sign;
  final Function onChange;
  const _TextArea({
    super.key,
    required this.sign,
    required this.onChange,
  });

  @override
  State<_TextArea> createState() => _TextAreaState();
}

class _TextAreaState extends State<_TextArea> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller.text = widget.sign;
    controller.addListener(() {
      widget.onChange(controller.text.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      color: Colors.white,
      child: TextField(
        controller: controller,
        maxLength: 30,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "填写个性签名",
          border: InputBorder.none,
        ),
        minLines: 4,
        maxLines: 4,
      ),
    );
  }
}
