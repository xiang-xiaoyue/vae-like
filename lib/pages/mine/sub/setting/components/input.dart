import 'package:flutter/material.dart';
import 'package:trump/components/input.dart';

class ItemForBind extends StatefulWidget {
  final String text;
  final bool isReverse;
  final Function onChange;
  const ItemForBind({super.key, 
    required this.text,
    this.isReverse = false,
    required this.onChange,
  });

  @override
  State<ItemForBind> createState() => _ItemForBindState();
}

class _ItemForBindState extends State<ItemForBind> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 32),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: widget.isReverse ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: GestureDetector(
              onTap: () {},
              child: Text(
                widget.text,
                style: TextStyle(color: Colors.blue[600]),
              ),
            ),
          ),
          Center(child: const _Divider()),
          Expanded(
              child: InputFieldFilledWhite(
            showSuffixIcon: false,
            onChange: widget.onChange,
          )),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.all(8.0),
      child: const VerticalDivider(
        indent: 2,
        endIndent: 2,
        color: Colors.grey,
        thickness: 1,
        width: 0,
      ),
    );
  }
}
