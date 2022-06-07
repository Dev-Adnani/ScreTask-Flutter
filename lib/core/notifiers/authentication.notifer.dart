import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scretask/app/constants/app.const.dart';
import 'package:scretask/app/routes/app.routes.dart';
import 'package:scretask/core/api/authentication.api.dart';
import 'package:scretask/core/models/user.auth.model.dart';
import 'package:scretask/core/services/photo.service.dart';
import 'package:scretask/presentation/widgets/snackbar.widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationNotifier with ChangeNotifier {
  final AuthenticationAPI _authenticationAPI = AuthenticationAPI();

  String? _userJWT;
  String? get userjwt => _userJWT;
  set userjwt(String? value) {
    _userJWT = value;
  }

  String? _secretCode;
  String? get getSecretCode => _secretCode;

  String? _email;
  String? get getEmail => _email;

  Future sendEmail({
    required String useremail,
    required BuildContext context,
  }) async {
    var userData = await _authenticationAPI.sendEmail(useremail: useremail);
    var response = UserAuthModel.fromJson(jsonDecode(userData));
    bool received = response.received!;
    String? secretcode = response.secretcode;
    String email = response.data!;
    if (received) {
      _secretCode = secretcode;
      _email = email;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
          text: 'Email Sent',
          context: context,
        ),
      );
      Navigator.of(context).pushReplacementNamed(AppRouter.signUpRoute);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
          text: email,
          context: context,
        ),
      );
    }
  }

  Future createAccount({
    required BuildContext context,
    required String username,
    required String secretcodeinput,
    required String userpassword,
  }) async {
    try {
      var userData = await _authenticationAPI.createAccount(
        useremail: _email!,
        username: username,
        userphoto: Provider.of<PhotoService>(context, listen: false).photo_url!,
        secretcode: _secretCode!,
        secretcodeinput: secretcodeinput,
        userpassword: userpassword,
      );
      final prefs = await SharedPreferences.getInstance();
      var response = UserAuthModel.fromJson(jsonDecode(userData));
      dynamic authData = response.data;
      print("response : ${response}");
      print("Email : ${response.emailVerification!}");
      print("Authentication : ${response.authentication!}");
      print("Auth : ${authData}");

      if (response.emailVerification! && response.authentication!) {
        _userJWT = authData;
        notifyListeners();
        await prefs.setString(AppConst.splashKey, authData).whenComplete(
              () => Navigator.of(context)
                  .pushReplacementNamed(AppRouter.homeRoute),
            );
      } else {
        Provider.of<PhotoService>(context, listen: false).file = null;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackUtil.stylishSnackBar(text: authData, context: context));
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
          text: 'Oops No You Need A Good Internet Connection',
          context: context,
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future userLogin(
      {required String useremail,
      required BuildContext context,
      required String userpassword}) async {
    try {
      var userData = await _authenticationAPI.userLogin(
          useremail: useremail, userpassword: userpassword);
      final prefs = await SharedPreferences.getInstance();

      var response = UserAuthModel.fromJson(jsonDecode(userData));
      bool isAuthenticated = response.authentication!;
      dynamic authData = response.data;

      if (isAuthenticated) {
        _userJWT = authData;
        notifyListeners();
        await prefs.setString(AppConst.splashKey, authData).whenComplete(
              () => Navigator.of(context)
                  .pushReplacementNamed(AppRouter.homeRoute),
            );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackUtil.stylishSnackBar(text: authData, context: context));
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
          text: 'Oops No You Need A Good Internet Connection',
          context: context,
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future userLogout({required BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConst.splashKey).whenComplete(
      () {
        userjwt = null;
        notifyListeners();
        Navigator.of(context).pushReplacementNamed(AppRouter.deciderRoute);
      },
    );
  }
}
