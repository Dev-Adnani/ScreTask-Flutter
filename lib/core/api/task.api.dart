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
}
