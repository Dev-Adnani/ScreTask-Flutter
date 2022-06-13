import 'package:flutter/material.dart';

class TypeNotifier with ChangeNotifier {
  String _type = 'Work';

  bool work = true;
  bool personal = false;
  bool health = false;

  String get getType => _type;

  select_work() {
    work = true;
    personal = false;
    health = false;
    _type = 'Work';
    notifyListeners();
  }

  select_personal() {
    work = false;
    personal = true;
    health = false;
    _type = 'Personal';
    notifyListeners();
  }

  select_health() {
    work = false;
    personal = false;
    health = true;
    _type = 'Health';
    notifyListeners();
  }

  DateTime datex = DateTime.now();
  

  Future selectDate({required BuildContext context}) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025, 12),
    );
    if (selectedDate != null && selectedDate != datex) {
      datex = selectedDate;
      notifyListeners();
    }
  }
}
