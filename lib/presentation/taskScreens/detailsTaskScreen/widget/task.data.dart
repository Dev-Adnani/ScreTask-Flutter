import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scretask/app/constants/app.colors.dart';
import 'package:scretask/core/models/task.model.dart';

Widget taskTile({required snapshot, required BuildContext context}) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: snapshot.length,
    itemBuilder: (context, index) {
      Task task = snapshot[index];
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.backColorList[Random().nextInt(
            AppColors.backColorList.length,
          )],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${task.taskTitle}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "${task.taskDesc}",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    },
  );
}
