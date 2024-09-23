import 'dart:io';

import 'package:path_provider/path_provider.dart';

class SaveService {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/trump_chat.txt');
  }

  static Future<File> writeString(String str) async {
    final file = await _localFile;
    return file.writeAsString(str);
  }

  static Future<String> readString() async {
    try {
      final file = await _localFile;
      return await file.readAsString();
    } catch (e) {
      return "";
    }
  }
}
