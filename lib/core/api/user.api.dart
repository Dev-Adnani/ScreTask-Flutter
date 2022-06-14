import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scretask/app/constants/app.const.dart';
import 'package:scretask/app/routes/api.routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataAPI {
  final client = http.Client();
  final headers = {};

  Future decodeUserData({
    required BuildContext context,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString(AppConst.splashKey);
    const subUrl = '/auth/verify';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);
    final http.Response response = await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': "*",
        'Authorization': action!
      },
    );
    final dynamic body = response.body;
    return body;
  }

  Future taskCount({required String userId}) async {
    var subUrl = '/task/count/$userId';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);
    final http.Response response = await client.get(
      uri,
      headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': "*",
    'Authorization': "test"
  },
    );
    final dynamic body = response.body;
    return body;
  }
}
