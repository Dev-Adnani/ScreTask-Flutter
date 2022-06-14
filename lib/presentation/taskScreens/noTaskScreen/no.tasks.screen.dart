import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scretask/app/constants/app.assets.dart';

Widget noTaskScreen({required String type}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 160,
        ),
        Lottie.asset(AppAssets.noData),
        Text(
          'Looks Like You Could\nAdd Some $type Tasks',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget loadingData() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 160,
        ),
        Lottie.asset(AppAssets.wait),
        const Text(
          'Please Wait While We Load Your \n Data From Our Servers',
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
