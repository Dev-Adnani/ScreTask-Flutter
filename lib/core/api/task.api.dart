// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scretask/app/routes/api.routes.dart';

class TaskAPI {
  final client = http.Client();
  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': "*",
    'Authorization': "test"
  };

  Future getTaskType({required String userId, required String type}) async {
    const subUrl = '/task/taskType';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);
    final http.Response response = await client.post(uri,
        headers: headers,
        body: jsonEncode({
          "userId": userId,
          "type": type,
        }));
    final dynamic body = response.body;
    return body;
  }

  Future deleteTask({required String taskId}) async {
    var subUrl = '/task/delete/$taskId';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);
    final http.Response response = await client.delete(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    return body;
  }

  Future addTask({
    required String userId,
    required String task_title,
    required String task_desc,
    required String task_type,
    required String task_date,
  }) async {
    const subUrl = '/task/add';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);
    final http.Response response = await client.post(uri,
        headers: headers,
        body: jsonEncode({
          "user_id": userId,
          "task_title": task_title,
          "task_desc": task_desc,
          "task_type": task_type,
          "task_date": task_date,
          "task_completed": false,
        }));
    final dynamic body = response.body;
    return body;
  }

  Future editTask({
    required String task_id,
    required String task_title,
    required String task_desc,
    required String task_type,
    required String task_date,
    required bool task_completed,
  }) async {
    const subUrl = '/task/update';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);
    final http.Response response = await client.put(uri,
        headers: headers,
        body: jsonEncode({
          "task_id":task_id,
          "task_title": task_title,
          "task_desc": task_desc,
          "task_type": task_type,
          "task_date": task_date,
          "task_completed": task_completed,
        }));
    final dynamic body = response.body;
    return body;
  }
}
