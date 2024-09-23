import 'package:flutter/foundation.dart';
import 'package:trump/models/request/subject.dart';
import 'package:trump/models/resp/models/subject.dart';
import 'package:trump/service/api.dart';

class CreateSubjectViewMode with ChangeNotifier {
  NewSubject ns = NewSubject();
  List<String> coverList = [];
  Subject? subject;

  Future createSubject() async {
    ns.coverUrlList = coverList.join(",");
    subject = await Api.instance.createSubject(ns);
    notifyListeners();
  }

  addCover(String url) {
    coverList.add(url);
    notifyListeners();
  }

  removeCover(String url) {
    coverList.remove(url);
    notifyListeners();
  }
}
