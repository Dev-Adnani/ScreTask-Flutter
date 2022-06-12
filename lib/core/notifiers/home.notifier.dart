import 'package:flutter/material.dart';

class HomeNotifier with ChangeNotifier {
  var dt = DateTime.now();
  String status = "Good Morning ";
  String get getStatus => status;

  String quote = "Start Your Day By \nAdding Tasks :)";
  String get getQuote => quote;

  void timeSetter() {
    if (dt.hour > 6 && dt.hour <= 12) {
      status = "Good Morning!";
      quote = "Start Your Day By \nAdding Tasks :)";
    } else if (dt.hour >= 13 && dt.hour < 17) {
      status = "Good Afternoon!";
      quote = "Just Remainder \nDid You Add All Tasks??";
    } else if (dt.hour >= 17 && dt.hour <= 21) {
      status = "Good Evening!";
      quote = "Hoping That You \nHave Completed Your Tasks";
    } else {
      status = "Good Night!";
      quote = "All The Best For \nTommorrow's Adventure";
    }
  }
}
