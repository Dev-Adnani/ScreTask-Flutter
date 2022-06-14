import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scretask/app/constants/app.colors.dart';
import 'package:scretask/core/notifiers/task.data.notifier.dart';
import 'package:scretask/presentation/widgets/custom.styles.dart';

Widget selectType({required BuildContext context}) {
  TaskDataNotifier typenotifier(bool renderUI) =>
      Provider.of<TaskDataNotifier>(context, listen: renderUI);
  return ListView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
    children: [
      GestureDetector(
        onTap: () {
          typenotifier(false).select_work();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.20,
            height: MediaQuery.of(context).size.height * 0.20,
            decoration: BoxDecoration(
              color: typenotifier(true).work
                  ? AppColors.kRedDark
                  : Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Work",
                  style: kColorText(
                    color:
                        typenotifier(true).work ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          typenotifier(false).select_health();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.20,
            height: MediaQuery.of(context).size.height * 0.20,
            decoration: BoxDecoration(
              color: typenotifier(true).health
                  ? AppColors.kRedDark
                  : Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Health",
                  style: kColorText(
                    color:
                        typenotifier(true).health ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          typenotifier(false).select_personal();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.20,
            height: MediaQuery.of(context).size.height * 0.20,
            decoration: BoxDecoration(
              color: typenotifier(true).personal
                  ? AppColors.kRedDark
                  : Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "Personal",
                  style: kColorText(
                    color: typenotifier(true).personal
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
