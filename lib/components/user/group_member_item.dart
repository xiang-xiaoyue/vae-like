import 'package:flutter/material.dart';
import 'package:trump/components/avatar.dart';

class GroupMemberItem extends StatelessWidget {
  const GroupMemberItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAvatar(size: 46, radius: 4),
          SizedBox(width: 8),
          Text(
            "断水流",
            style: TextStyle(fontSize: 18),
          ),
          Icon(
            Icons.female,
            size: 24,
            color: Colors.pinkAccent,
          ), //todo,后面有个数字30,是积分
          //todo:后面有个符号，里面只一个“嵩”字，不知是什么，不像是徽章。
          Spacer(),
          //_IdentityText(),
          _IdentifyTag(text: "管理"),
        ],
      ),
    );
  }
}

class _IdentifyTag extends StatelessWidget {
  final String text;
  const _IdentifyTag({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: text == "群主" ? Colors.blue : Colors.green,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}
