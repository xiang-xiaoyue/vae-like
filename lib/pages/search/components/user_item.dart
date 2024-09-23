// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trump/components/avatar.dart';
import 'package:trump/components/index.dart';
import 'package:trump/models/resp/models/user.dart';

class SearchUserItem extends StatelessWidget {
  final User user;
  final Function? leftOnTap;
  final bool toUserDetail;
  final bool showRight;
  final Function? rightOnTap; // todo:为了兼容加此方法
  SearchUserItem({
    super.key,
    required this.user,
    this.leftOnTap,
    this.rightOnTap,
    this.toUserDetail = true,
    this.showRight = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      color: Colors.white,
      height: 64,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserAvatar(
              url: user.avatarUrl, hintText: user.name[0], onTap: leftOnTap),
          const SizedBox(width: 10),
          Expanded(
            flex: 0,
            child: GestureDetector(
              onTap: () {
                if (leftOnTap != null) {
                  leftOnTap!();
                } else {
                  if (toUserDetail == true) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    context.pushNamed(
                      "user_detail",
                      pathParameters: {"id": user.id.toString()},
                    );
                  }
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.end,
                      ),
                      //_GenderIcon(),
                    ],
                  ),
                  Text(
                    "${user.age}岁",
                    style: const TextStyle(color: Colors.blueGrey),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          showRight == true
              ? GestureDetector(
                  onTap: () {
                    if (rightOnTap != null) {
                      rightOnTap!();
                    }
                  },
                  child: Icon(
                    user.isFollowing == true
                        ? Icons.remove_rounded
                        : Icons.add_box,
                    color: Colors.blue,
                    size: 36,
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

class _GenderIcon extends StatelessWidget {
  const _GenderIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Icon(
        Icons.female,
        size: 12,
        color: Colors.white,
      ),
    );
  }
}
