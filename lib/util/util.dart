import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/service/api.dart';

// 1000 -> 1k
// 1,000,000 -> 100w
// 1,000,000,000 -> 10kw
String countToText(int count) {
  String text;
  if (count < 0) {
    text = "0";
  } else if (count < 1000 && count >= 0) {
    text = count.toString();
  } else if (count > 1000 && count < 10000) {
    text = '${count ~/ 1000}k';
  } else if (count >= 1e4 && count < 1e7) {
    text = "${count ~/ 1e4}w";
  } else if (count >= 1e7 && count < 1e8) {
    text = "${count ~/ 1e7}kw";
  } else {
    text = "nb"; //numbers billion
  }
  return text;
}

// 把时间毫秒级时间戳转成相对时间
String relativeTime(int stamp, {String ext = "前"}) {
  if (stamp <= 0) {
    return "未知时间";
  }
  DateTime start = DateTime.fromMillisecondsSinceEpoch(stamp);
  DateTime now = DateTime.now();
  if (now.millisecondsSinceEpoch <= start.millisecondsSinceEpoch) {
    return "刚刚";
  }
  var dt = DateTimeRange(start: start, end: now);

  int days = dt.duration.inDays;
  int hours = dt.duration.inHours - dt.duration.inDays * 24;
  int minutes = dt.duration.inMinutes - dt.duration.inHours * 60;
  int seconds = dt.duration.inSeconds - dt.duration.inMinutes * 60;

  String text;
  if (days > 0) {
    text = "$days天";
  } else if (hours > 0) {
    text = "$hours小时";
  } else if (minutes > 0) {
    text = "$minutes分钟";
  } else {
    text = "$seconds秒";
  }
  return "$text$ext";

  //return "$days天$hours小时$minutes分钟";
}

// 把时间毫秒级时间戳转成绝对时间
String absoluteTime(int stamp,
    {bool requireYear = true, bool onlyDate = false}) {
  if (stamp <= 0) {
    return "未知时间";
  }
  DateTime dt = DateTime.fromMillisecondsSinceEpoch(stamp);
  int year = dt.year;
  int month = dt.month;
  int day = dt.day;
  int hour = dt.hour;
  int minute = dt.minute;

  String str =
      "${month < 10 ? '0' : ''}$month-${day < 10 ? '0' : ''}$day ${hour < 10 ? '0' : ''}$hour:${minute < 10 ? '0' : ''}$minute";
  if (onlyDate == true) {
    return "$year-${month < 10 ? '0' : ''}$month-${day < 10 ? '0' : ''}$day";
  } else if (requireYear == true) {
    return "$year-$str";
  } else {
    return str;
  }
}

// 上传单个图片
Future<String> uploadSingleSelectedFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    //PlatformFile file = result.files.first;
    File file = File(result.files.single.path!);
    FormData fd = FormData.fromMap({
      'file': MultipartFile.fromFileSync(file.path),
      //"file": MultipartFile.fromBytes(await file.readAsBytes()).finalize(),
    });
    Resp resp = await Api.instance.uploadSingleFile(fd);
    if (resp.code == 0) {
      return "${TrumpCommon.baseURL}files/${resp.data}";
    } else {
      return resp.msg ?? '失败';
    }
  }
  return "";
}

// 上传文件
Future<String> uploadSingleFile(String filePath) async {
  File file = File(filePath);
  // Uint8List bytes = await file.readAsBytes();
  // Stream<List<int>> stream = MultipartFile.fromBytes(bytes).finalize();

  Resp resp = await Api.instance.uploadSingleFile(FormData.fromMap({
    "file": MultipartFile.fromFileSync(file.path),
    //"file": MultipartFile.fromBytes(await file.readAsBytes()).finalize(),
  }));
  if (resp.code == 0) {
    return "${TrumpCommon.baseURL}files/${resp.data}";
  } else {
    return resp.msg ?? '失败';
  }
}
