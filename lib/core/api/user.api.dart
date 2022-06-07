import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:scretask/app/routes/api.routes.dart';
import 'package:scretask/core/notifiers/authentication.notifer.dart';

class UserDataAPI {
  final client = http.Client();
  final headers = {};

  Future decodeUserData({
    required BuildContext context,
  }) async {
    const subUrl = '/auth/verify';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);
    final http.Response response = await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': "*",
        'Authorization':
            Provider.of<AuthenticationNotifier>(context, listen: false).userjwt!
      },
    );
    final dynamic body = response.body;
    return body;
  }
}
