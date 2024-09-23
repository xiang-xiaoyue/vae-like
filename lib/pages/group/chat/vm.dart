import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trump/models/request/msg.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/group.dart';
import 'package:trump/models/resp/models/msg.dart';
import 'package:trump/service/api.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GroupChatViewModel with ChangeNotifier {
  Group? group;
  late WebSocketChannel channel;
  GroupChatViewModel(String id) {
    connect();
    getGroupDetail(id);
  }
  List<Msg> msgs = [];

  Future connect() async {
    channel = await Api.instance.connect();
    channel.stream.listen((msg) {
      msgs.add(msgFromJson(msg));
      notifyListeners();
    });
    notifyListeners();
  }

  // 获取群信息
  Future getGroupDetail(String id) async {
    group = await Api.instance.getGroupDetail(id);
    await getMsgList();
    notifyListeners();
  }

  // 获取群内所有聊天消息
  Future getMsgList() async {
    ListResp listResp = await Api.instance.getMsgList(groupId: group!.id);
    listResp.list?.forEach((i) {
      msgs.add(Msg.fromJson(i));
    });
    notifyListeners();
  }

  // 发送消息
  void sendMsg(String msg) {
    if (msg.isNotEmpty) {
      NewMsg newMsg = NewMsg(
        content: msg,
        groupId: group!.id,
        url: '',
        toUserId: 0,
        contentType: "text",
        poster: '',
      );
      channel.sink.add(json.encode(newMsg));
      notifyListeners();
    }
    notifyListeners();
  }

  // 销毁channel
  void disposeChannel() {
    channel.sink.close();
  }
}
