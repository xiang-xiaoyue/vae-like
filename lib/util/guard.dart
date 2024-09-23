import 'package:trump/service/save.dart';

Future<bool> authGuard() async {
  String t = await SaveService.readString();
  return t != "";
}
