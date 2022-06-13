import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scretask/app/constants/app.assets.dart';
import 'package:scretask/app/constants/app.colors.dart';
import 'package:scretask/core/models/task.model.dart';
import 'package:scretask/core/notifiers/task.notiifer.dart';

Widget taskTile({required snapshot, required BuildContext context}) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: snapshot.length,
    itemBuilder: (context, index) {
      Task task = snapshot[index];
      return Dismissible(
        background: slideRightBackground(),
        secondaryBackground: slideLeftBackground(),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text(
                      "Are you sure you want to delete ${task.taskTitle}?",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          Provider.of<TaskNotifier>(context, listen: false)
                              .deleteTask(
                                  taskId: task.taskId, context: context);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          } else {}
          return null;
        },
        key: Key(task.taskId),
        child: GestureDetector(
          onTap: () {
            print(task.taskId);
          },
          child: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.only(left: 15, right: 15, top: 15),
            decoration: BoxDecoration(
              color: AppColors.backColorList[Random().nextInt(
                AppColors.backColorList.length,
              )],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    task.taskTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    task.taskDesc,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Image.asset(AppAssets.clock, width: 20),
                      SizedBox(width: 8),
                      Text(
                        task.taskDate,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.perano.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          task.taskType,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color:
                              (task.taskCompleted ? Colors.green : Colors.red)
                                  .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          task.taskCompleted ? 'Done' : 'On Going',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget slideRightBackground() {
  return Container(
    color: Colors.green,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          Text(
            " Edit",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
    ),
  );
}

Widget slideLeftBackground() {
  return Container(
    color: Colors.red,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text(
            " Delete",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      alignment: Alignment.centerRight,
    ),
  );
}
