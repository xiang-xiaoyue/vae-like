import 'package:flutter/material.dart';

String toColor(Color color) {
  String alpha = color.alpha.toRadixString(16);
  String r = color.red.toRadixString(16);
  String g = color.green.toRadixString(16);
  String b = color.blue.toRadixString(16);
  print("0x$alpha$r$g$b");
  return "0x$alpha$r$g$b";
}
