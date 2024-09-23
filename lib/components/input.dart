import 'package:flutter/material.dart';

// 纯粹的输入框，用于绑定手机号，填写新旧密码
class InputFieldFilledWhite extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function? onChange;
  final bool showSuffixIcon;
  const InputFieldFilledWhite({
    super.key,
    this.hintText = "",
    this.controller,
    this.onChange,
    this.showSuffixIcon = true,
  });

  @override
  State<InputFieldFilledWhite> createState() => _InputFieldFilledWhiteState();
}

class _InputFieldFilledWhiteState extends State<InputFieldFilledWhite> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      textInputAction: TextInputAction.newline,
      obscureText: show,
      style: TextStyle(textBaseline: TextBaseline.alphabetic, height: 1),
      onChanged: (v) {
        if (widget.onChange != null) {
          widget.onChange!(v.trim());
          setState(() {});
        }
      },
      cursorHeight: 16,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        suffixIcon: widget.showSuffixIcon == true
            ? GestureDetector(
                onTap: () => setState(() => show = !show),
                child: Icon(
                  !show ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              )
            : SizedBox(),
      ),
    );
  }
}

// 用于搜索的输入框，有搜索图标和清除图标
class CommonSearchTextField extends StatelessWidget {
  final Function? onChange;
  final String hintText;
  final double borderRadiusSize;
  const CommonSearchTextField({
    super.key,
    this.onChange,
    this.hintText = '',
    this.borderRadiusSize = 8,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (v) {
        if (onChange != null) {
          onChange!(v);
        }
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        constraints: const BoxConstraints(maxHeight: 36),
        prefixIcon: Icon(
          Icons.search_rounded,
          color: Colors.grey.withAlpha(100),
        ),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadiusSize),
          gapPadding: 0,
          borderSide: BorderSide.none,
          //borderSide: BorderSide(width: 1, color: Colors.redAccent),
        ),
      ),
    );
  }
}
