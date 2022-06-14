// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scretask/app/routes/app.routes.dart';
import 'package:scretask/core/api/user.api.dart';
import 'package:scretask/core/models/user.data.model.dart';
import 'package:scretask/presentation/widgets/snackbar.widget.dart';

class UserDataNotifier with ChangeNotifier {
  final UserDataAPI _dataAPI = UserDataAPI();

  String? _email;
  String? get getEmail => _email;

  String? _name;
  String? get getName => _name;

  String? _id;
  String? get getID => _id;

  String? _photo;
  String? get getPhoto => _photo;

  bool _allowTouch = false;
  bool get getAllowTouch => _allowTouch;

  int? total_tasks;
  int? get getTotalTasks => total_tasks;

  int? completed_tasks;
  int? get getCompletedTasks => completed_tasks;

  Future<bool> decodeUserData({
    required BuildContext context,
  }) async {
    var userData = await _dataAPI.decodeUserData(context: context);
    var response = userDataModelFromJson(userData);
    bool received = response.received;

    if (!received) {
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
          text: "Sign In Expired",
          context: context,
        ),
      );
      Navigator.of(context).pushReplacementNamed(AppRouter.deciderRoute);
      return false;
    } else {
      var userData = response.data!;
      _email = userData.email;
      _id = userData.id;
      _name = userData.name;
      _photo = userData.photo;
      _allowTouch = true;
      notifyListeners();
      taskCount();
      return true;
    }
  }

  Future taskCount() async {
    var countData = await _dataAPI.taskCount(userId: _id!);
    final Map<String, dynamic> parseData = await jsonDecode(countData);
    bool isReceived = parseData['received'];
    bool isAvailable = parseData['available'];

    if (isAvailable & isReceived) {
      total_tasks = parseData['total_count'];
      completed_tasks = parseData['completed_count'];
      notifyListeners();
    } else {
      total_tasks = 0;
      completed_tasks = 0;
    }
  }
}
