import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scretask/core/api/task.api.dart';
import 'package:scretask/core/models/task.model.dart';
import 'package:scretask/presentation/widgets/snackbar.widget.dart';

class TaskNotifier with ChangeNotifier {
  final TaskAPI _taskAPI = TaskAPI();

  List<Task>? _task;
  List<Task>? get getTask => _task;

  Future getTaskType(
      {required String userId,
      required String type,
      required BuildContext context}) async {
    try {
      var data = await _taskAPI.getTaskType(userId: userId, type: type);
      final response = TaskModel.fromJson(jsonDecode(data));
      final _productReceived = response.received;
      final _productAvailable = response.available;
      _task = response.data;
      if (_productAvailable && _productReceived) {
        return _task;
      } else {
        return null;
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
          text: 'Oops No You Need A Good Internet Connection',
          context: context));
    }
  }

  Future deleteTask(
      {required String taskId, required BuildContext context}) async {
    try {
      var data = await _taskAPI.deleteTask(taskId: taskId);
      final Map<String, dynamic> parseData = await jsonDecode(data);
      bool isDeleted = parseData['deleted'];
      _task?.remove(taskId);
      notifyListeners();
      return isDeleted;
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
            text: 'Oops No You Need A Good Internet Connection',
            context: context),
      );
    }
  }
}
