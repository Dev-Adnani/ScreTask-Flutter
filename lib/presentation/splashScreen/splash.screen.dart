import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scretask/app/constants/app.const.dart';
import 'package:scretask/app/routes/app.routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _initiateCache() async {
    final prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString(AppConst.splashKey);
    if (action == null) {
      Navigator.of(context).pushNamed(AppRouter.deciderRoute);
    } else {
      Navigator.of(context).pushNamed(AppRouter.homeRoute);
    }
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 1), _initiateCache);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Scre Task',
          style: TextStyle(
            fontSize: 42,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
