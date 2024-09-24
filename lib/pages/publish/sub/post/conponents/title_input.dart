import 'package:flutter/material.dart';
import 'package:trump/pages/publish/sub/post/vm.dart';

// 输入post标题的输入框
class PostTitleInput extends StatefulWidget {
  final Function onChange;
  final CreatePostViewModel? vm;
  const PostTitleInput({
    super.key,
    required this.onChange,
    this.vm,
  });

  @override
  State<PostTitleInput> createState() => _PostTitleInputState();
}

class _PostTitleInputState extends State<PostTitleInput> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller.text = widget.vm?.np.title ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 1,
      maxLength: 30,
      onChanged: (v) => widget.onChange(v),
      decoration: const InputDecoration(
        filled: true,
        counterText: "",
        fillColor: Colors.white,
        hintText: "标题（30字内）",
        border: InputBorder.none,
      ),
    );
  }
}
