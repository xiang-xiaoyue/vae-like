import 'package:json_annotation/json_annotation.dart';

part 'resp.g.dart';

@JsonSerializable()
class Resp {
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "msg")
  String? msg;
  @JsonKey(name: "data")
  dynamic data; // data可能是带有count,list的映射,也可能是一个实体，或空

  Resp({
    this.code,
    this.msg,
    this.data,
  });

  factory Resp.fromJson(Map<String, dynamic> json) => _$RespFromJson(json);

  Map<String, dynamic> toJson() => _$RespToJson(this);
}

class ListResp {
  List<dynamic>? list;
  int? count;
  ListResp({
    this.list,
    this.count,
  });

  ListResp.toListResp(Resp resp) {
    count = int.tryParse(resp.msg ?? "0");
    list = resp.data;
  }
}
