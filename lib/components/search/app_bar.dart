import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trump/configs/const.dart';

// todo：挪位置
class SearchAppBar extends StatelessWidget {
  final String text;
  final Function? onSubmit;
  final Function? onCancel;
  const SearchAppBar({
    super.key,
    this.text = "发现群组",
    this.onCancel,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        color: Colors.white,
        height: TrumpSize.searchAppBarHeight,
        child: Column(
          children: [
            _AppBar(text: text),
            _SearchInput(onSubmit: onSubmit, onCancel: onCancel), //搜索框
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  final String text;
  const _AppBar({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 8),
          GestureDetector(
            child: const Icon(
              Icons.chevron_left,
              size: 24,
            ),
            onTap: () {
              context.pop();
            },
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }
}

class _SearchInput extends StatefulWidget {
  final Function? onSubmit;
  final Function? onCancel;
  const _SearchInput({
    this.onSubmit,
    this.onCancel,
  });

  @override
  State<_SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<_SearchInput> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller,
        onSubmitted: (value) {
          if (widget.onSubmit != null) {
            widget.onSubmit!(value);
          }
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: "搜索群组",
          suffixIcon: GestureDetector(
            onTap: () {
              if (widget.onCancel != null) {
                widget.onCancel!();
              }
              controller.text = '';
            },
            child: Icon(
              Icons.cancel,
              color: Colors.grey[400],
            ),
          ),
          contentPadding: const EdgeInsets.all(0),
          fillColor: Colors.grey[300],
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
        ),
      ),
    );
  }
}
