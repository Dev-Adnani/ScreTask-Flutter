import 'package:flutter/material.dart';
import 'package:scretask/app/constants/app.colors.dart';
import 'package:scretask/app/routes/app.routes.dart';

class TaskTypeModel {
  IconData? iconData;
  String? title;
  Color? bgColor;
  Color? iconColor;
  Color? btnColor;
  bool isLast;
  num? left;
  num? done;

  TaskTypeModel({
    this.iconData,
    this.title,
    this.bgColor,
    this.btnColor,
    this.iconColor,
    this.isLast = false,
    this.done,
    this.left,
  });

  static List<TaskTypeModel> generateTask({required BuildContext context}) {
    return [
      TaskTypeModel(
        iconData: Icons.person_rounded,
        title: 'Personal',
        bgColor: AppColors.kYellowLight,
        iconColor: AppColors.kYellowDark,
        btnColor: AppColors.kYellow,
        left: 3,
        done: 1,
      ),
      TaskTypeModel(
        iconData: Icons.cases_rounded,
        title: 'Work',
        bgColor: AppColors.kRedLight,
        iconColor: AppColors.kRedDark,
        btnColor: AppColors.kRed,
        left: 2,
        done: 0,
      ),
      TaskTypeModel(
        iconData: Icons.favorite_rounded,
        title: 'Health',
        bgColor: AppColors.kBlueLight,
        iconColor: AppColors.kBlueDark,
        btnColor: AppColors.kBlue,
        left: 1,
        done: 1,
      ),
      TaskTypeModel(isLast: true),
    ];
  }
}
