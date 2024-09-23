import 'package:flutter/material.dart';
import 'package:trump/components/leading.dart';
import 'package:trump/configs/const.dart';

class MsgGoBackLeading extends StatelessWidget {
  const MsgGoBackLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      width: 30,
      top: 0,
      height: TrumpSize.appBarHeight,
      child: const GoBackLeading(),
    );
  }
}
