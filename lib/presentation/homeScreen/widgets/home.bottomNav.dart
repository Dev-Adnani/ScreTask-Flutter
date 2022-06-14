import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:scretask/app/constants/app.colors.dart';

Widget homeBottomNav({required int index, required PageController controller}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 10,
          spreadRadius: 5,
        )
      ],
    ),
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft:  Radius.circular(30),
        topRight:  Radius.circular(30),
      ),
      child: CustomNavigationBar(
        strokeColor: Colors.transparent,
        backgroundColor: Colors.white,
        currentIndex: index,
        onTap: (val) {
          index = val;
          controller.jumpToPage(val);
        },
        selectedColor: AppColors.kRedDark,
        unSelectedColor: Colors.grey.withOpacity(0.5),
        items: [
          CustomNavigationBarItem(
            icon: const Icon(
              Icons.home_rounded,
              size: 30,
            ),
          ),
          CustomNavigationBarItem(
            icon: const Icon(
              Icons.person_rounded,
              size: 30,
            ),
          )
        ],
      ),
    ),
  );
}
