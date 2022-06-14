// ignore_for_file: list_remove_unrelated_type, use_build_context_synchronously, non_constant_identifier_names, no_leading_underscores_for_local_identifiers

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

  Future addTask({
    required String userId,
    required String task_title,
    required String task_desc,
    required String task_type,
    required String task_date,
    required BuildContext context,
  }) async {
    try {
      var data = await _taskAPI.addTask(
          userId: userId,
          task_title: task_title,
          task_desc: task_desc,
          task_type: task_type,
          task_date: task_date);

      final Map<String, dynamic> parseData = await jsonDecode(data);
      bool isAdded = parseData['added'];
      dynamic status = parseData['data'];
      if (isAdded) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackUtil.stylishSnackBar(
            text: status,
            context: context,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackUtil.stylishSnackBar(
            text: "Some Error Occured",
            context: context,
          ),
        );
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
            text: 'Oops No You Need A Good Internet Connection',
            context: context),
      );
    }
  }

  Future editTask(
      {required String task_title,
      required String task_desc,
      required String task_type,
      required String task_date,
      required String task_id,
      required bool task_completed,
      required BuildContext context}) async {
    try {
      var data = await _taskAPI.editTask(
        task_title: task_title,
        task_id: task_id,
        task_desc: task_desc,
        task_type: task_type,
        task_date: task_date,
        task_completed: task_completed,
      );

      final Map<String, dynamic> parseData = await jsonDecode(data);
      bool isUpdated = parseData['updated'];
      dynamic status = parseData['data'];
      if (isUpdated) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackUtil.stylishSnackBar(
            text: status,
            context: context,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackUtil.stylishSnackBar(
            text: "Some Error Occured",
            context: context,
          ),
        );
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
            text: 'Oops No You Need A Good Internet Connection',
            context: context),
      );
    }
  }
}
