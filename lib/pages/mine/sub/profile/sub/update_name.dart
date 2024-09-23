// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/pages/mine/vm.dart';
import 'package:trump/vm.dart';

//修改昵称
class UpdateNamePage extends StatefulWidget {
  final String currentName;
  const UpdateNamePage({super.key, this.currentName = ""});

  @override
  State<UpdateNamePage> createState() => _UpdateNamePageState();
}

class _UpdateNamePageState extends State<UpdateNamePage> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentName);
  }

  @override
  Widget build(BuildContext context) {
    var _appBar = CommonAppBar(
      title: "修改用户名",
      rightPadding: 0,
      actions: [
        Consumer<CurrentUserViewModel>(builder: (context, vm, child) {
          return TextButton(
            onPressed: () {
              vm.user!.name = _controller.text.trim();
              vm.updateCurrentUser();
              //context.pop(_controller.text.trim());
              context.pop();
            },
            child: const Text(
              "完成",
              style: TextStyle(fontSize: 18),
            ),
          );
        }),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: _appBar,
      body: Column(
        children: [
          const SizedBox(height: 4),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              suffix: GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.text = "";
                  });
                },
                child: const Icon(Icons.cancel),
              ),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
