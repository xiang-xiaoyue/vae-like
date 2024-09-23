import 'package:flutter/material.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/models/resp/models/pay_note.dart';
import 'package:trump/service/api.dart';

class PayNoteViewModel with ChangeNotifier {
  PayNoteViewModel() {
    getPayNoteList();
  }
  List<PayNote> notes = [];

  Future getPayNoteList() async {
    ListResp listResp = await Api.instance.getPayNoteList();
    notes.clear();
    listResp.list?.forEach((i) {
      notes.add(PayNote.fromJson(i));
    });
    notifyListeners();
  }
}
