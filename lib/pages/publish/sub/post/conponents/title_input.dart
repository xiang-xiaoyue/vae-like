import 'package:flutter/material.dart';

// 输入post标题的输入框
class PostTitleInput extends StatelessWidget {
  final Function onChange;
  const PostTitleInput({
    super.key,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 1,
      maxLength: 30,
      onChanged: (v) => onChange(v),
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
