import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/pages/publish/sub/post/conponents/content_input.dart';
import 'package:trump/pages/publish/sub/post/vm.dart';

// 短文
class NewPostPureTextMain extends StatelessWidget {
  const NewPostPureTextMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CreatePostViewModel>(builder: (context, vm, child) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: vm.selectedColor,
        child: Consumer<CreatePostViewModel>(builder: (context, vm, child) {
          return NewPostTextarea(
            onChange: (v) => vm.np.content = v.trim(),
          );
        }),
      );
    });
  }
}
