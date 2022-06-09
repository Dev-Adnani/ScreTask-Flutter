import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scretask/app/constants/app.assets.dart';

Widget noTaskScreen({required String type}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(AppAssets.noData),
        Text(
          'Looks Like You Could\nAdd Some $type Tasks',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
