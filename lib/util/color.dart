import 'package:flutter/material.dart';

String color2String(Color color) {
  String alpha = color.alpha.toRadixString(16);
  String r = color.red.toRadixString(16);
  String g = color.green.toRadixString(16);
  String b = color.blue.toRadixString(16);
  print("0x$alpha$r$g$b");
  return "0x$alpha$r$g$b";
}

// string: '0xff112233'
Color string2Color(String str) {
  if (str.length == 10 && str.contains("0x") == true) {
    int a = int.tryParse(str.substring(2, 4), radix: 16) ?? 255;
    int r = int.tryParse(str.substring(4, 6), radix: 16) ?? 255;
    int g = int.tryParse(str.substring(6, 8), radix: 16) ?? 255;
    int b = int.tryParse(str.substring(8, 10), radix: 16) ?? 255;
    return Color.fromARGB(a, r, g, b);
  }
  return Colors.white;
}
