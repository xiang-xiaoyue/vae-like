import 'package:flutter/material.dart';
import 'package:trump/pages/publish/sub/post/vm.dart';

// 创建post时的内容输入框
class NewPostTextarea extends StatefulWidget {
  final Function onChange;
  final bool hideCounter;
  final CreatePostViewModel? vm;
  const NewPostTextarea({
    super.key,
    required this.onChange,
    this.hideCounter = false,
    this.vm,
  });

  @override
  State<NewPostTextarea> createState() => _NewPostTextareaState();
}

class _NewPostTextareaState extends State<NewPostTextarea> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller.text = widget.vm?.np.content ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 13,
      minLines: 8,
      maxLength: 150,
      onChanged: (v) => widget.onChange(v),
      decoration: InputDecoration(
        counterStyle: widget.hideCounter == true
            ? const TextStyle(color: Colors.transparent, fontSize: 0)
            : const TextStyle(),
        contentPadding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
        filled: true,
        fillColor: Colors.transparent,
        border: InputBorder.none,
        hintText: "想说点什么...",
      ),
    );
  }
}

class CustomTextEditingController extends TextEditingController {
  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    final bool composingRegionOutOfRange =
        !value.isComposingRangeValid || !withComposing;

    // todo: 无法输入文字
    List<InlineSpan> getRichTextSpans(String richText) {
      List<TextSpan> children = [];
      if (richText.isNotEmpty && richText.contains("@")) {
        List<String> strs = text.split("@");
        for (var str in strs) {
          if (str.isNotEmpty && str.contains(" ")) {
            List<String> unameInStrs = str.split(" ");
            for (int i = 0; i < unameInStrs.length; i++) {
              if (i == 0) {
                children.add(TextSpan(
                    text: " @${unameInStrs[i]} ",
                    style: TextStyle(color: Colors.purple)));
              } else {
                if (unameInStrs[i].isNotEmpty) {
                  children.add(TextSpan(text: unameInStrs[i], style: style));
                }
              }
            }
          } else {
            if (str.isNotEmpty) {
              children.add(TextSpan(text: str, style: style));
            }
          }
        }
      }
      return children;
    }

    List<InlineSpan> children = getRichTextSpans(value.text);
    if (composingRegionOutOfRange) {
      return TextSpan(style: style, children: children);
    }
    if (!value.composing.isValid || !withComposing) {
      return TextSpan(style: style, text: text);
    }

    final TextStyle composingStyle =
        style?.merge(const TextStyle(decoration: TextDecoration.underline)) ??
            const TextStyle(decoration: TextDecoration.underline);
    return TextSpan(
      style: style,
      children: <TextSpan>[
        TextSpan(text: value.composing.textBefore(value.text)),
        TextSpan(
          style: composingStyle,
          text: value.composing.textInside(value.text),
        ),
        TextSpan(text: value.composing.textAfter(value.text)),
      ],
    );
  }
}
