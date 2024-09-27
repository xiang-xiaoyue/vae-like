// To parse this JSON data, do
//
//     final currency = currencyFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'currency.g.dart';

Currency currencyFromJson(String str) => Currency.fromJson(json.decode(str));

String currencyToJson(Currency data) => json.encode(data.toJson());

@JsonSerializable()
class Currency {
  @JsonKey(name: "type")
  String type;
  @JsonKey(name: "amount")
  int amount;
  @JsonKey(name: "user_id")
  int userId;

  Currency({
    required this.type,
    required this.amount,
    required this.userId,
  });

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}
