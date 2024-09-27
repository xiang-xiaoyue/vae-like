// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/pages/search/sub/user/vm.dart';

class InputAppBar extends StatefulWidget {
  const InputAppBar({super.key});

  @override
  State<InputAppBar> createState() => _InputAppBarState();
}

class _InputAppBarState extends State<InputAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Row(
        children: [
          const GoBackLeading(),
          const SizedBox(width: 10),
          Consumer<SearchUserViewModel>(builder: (context, vm, child) {
            return Expanded(
              child: CommonSearchTextField(onChange: (v) {
                setState(() => vm.keyword = v.trim());
              }),
            );
          }),
          const SizedBox(width: 10),
          Consumer<SearchUserViewModel>(builder: (context, vm, child) {
            return GestureDetector(
              child: const Text(
                "搜索",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              onTap: () {
                vm.getUserListWithKeyword();
              },
            );
          }),
        ],
      ),
    );
  }
}
