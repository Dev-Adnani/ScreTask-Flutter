import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scretask/app/routes/api.routes.dart';

class AuthenticationAPI {
  final client = http.Client();
  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': "*",
    'Authorization': "test"
  };
  Future createAccount({
    required String useremail,
    required String username,
    required String userphoto,
    required String secretcode,
    required String secretcodeinput,
    required String userpassword,
  }) async {
    const subUrl = '/auth/signup';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);
    final http.Response response = await client.post(uri,
        headers: headers,
        body: jsonEncode({
          "useremail": useremail,
          "userpassword": userpassword,
          "username": username,
          "userphoto": userphoto,
          "secretcode": secretcode,
          "secretcodeinput": secretcodeinput,
        }));
    final dynamic body = response.body;
    return body;
  }

  Future userLogin(
      {required String useremail, required String userpassword}) async {
    const subUrl = '/auth/login';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);
    final http.Response response = await client.post(uri,
        headers: headers,
        body: jsonEncode({
          "useremail": useremail,
          "userpassword": userpassword,
        }));
    final dynamic body = response.body;
    return body;
  }

  Future sendEmail({required String useremail}) async {
    const subUrl = '/auth/send-email-verification';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);
    final http.Response response = await client.post(uri,
        headers: headers,
        body: jsonEncode({
          "useremail": useremail,
        }));
    final dynamic body = response.body;
    return body;
  }
}
