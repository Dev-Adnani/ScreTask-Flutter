import 'package:flutter/material.dart';
import 'package:scretask/app/constants/app.colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Scre Task',
          style: TextStyle(
            fontSize: 42,
            color: AppColors.kBlue,
          ),
        ),
      ),
    );
  }
}
