import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//todo:支付
class ChargeViewModel with ChangeNotifier {
  String url = "https://m.jiuwufu.com/api/pay/submit";
  String api = "https://m.jiuwufu.com/";
  int pid = 1002;
  String secret = "Ve5qZqaVOyEuV4QrOxp7WSp09fGyb99a";
  String type = "wxpay";
  String outTradeNo = "";
  String name = "余额";
  String money = "1.0";
  String param = "";
  String stamp = "0"; // 1721206072
  String sign = "";
  String signType = "MD5";

  //rsa算法生成sign
  String geneSign() {
    String data =
        "money=$money&name=$name&notify_url=${api}notify_url.php&out_trade_no=$outTradeNo&param=$param&pid=$pid&return_url=${api}return_url.php&timestamp=$stamp&type=$type$secret";
    Uint8List content = Utf8Encoder().convert(data);
    Digest digest = md5.convert(content);
    return digest.toString();
  }

  // 拉起支付
  Future pay() async {
    stamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    sign = geneSign();
    var res = await Dio().get(url, queryParameters: {
      "pid": pid,
      "type": type,
      "out_trade_no": outTradeNo,
      "notify_url": "${api}notify_url.php",
      "return_url": "${api}return_url.php",
      "name": name,
      "money": money,
      "param": param,
      "timestamp": stamp,
      "sign": sign,
      "sign_type": signType,
    });
    var data = (res.data as Map<String, dynamic>)['data'];
    print(json.encode(data));
  }
}
