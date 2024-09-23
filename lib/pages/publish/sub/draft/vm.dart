import 'package:flutter/material.dart';

class DraftViewModel with ChangeNotifier {
  bool isEditing = false;
  void toggleEditing() {
    isEditing = !isEditing;
    notifyListeners();
  }
}
