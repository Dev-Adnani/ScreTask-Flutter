import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scretask/app/constants/app.assets.dart';
import 'package:scretask/app/constants/app.colors.dart';
import 'package:scretask/app/routes/app.routes.dart';
import 'package:scretask/core/models/task.model.dart';
import 'package:scretask/core/notifiers/task.notiifer.dart';
import 'package:scretask/presentation/taskScreens/editTaskScreen/edit.tasks.screen.dart';

Widget taskTile({required snapshot, required BuildContext context}) {
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: snapshot.length,
    itemBuilder: (context, index) {
      Task task = snapshot[index];
      return Dismissible(
        background: slideLeftBackground(),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text(
                      "Are you sure you want to delete ${task.taskTitle}?",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text(
                          "Cancel",
                          style:  TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text(
                          "Delete",
                          style:  TextStyle(color: Colors.red),
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
          }
          return null;
        },
        key: Key(task.taskId),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRouter.editTask,
              arguments: EditTaskArgs(
                task_id: task.taskId,
                task_title: task.taskTitle,
                task_desc: task.taskDesc,
                task_type: task.taskType,
                task_date: task.taskDate,
                taskStatus: task.taskCompleted,
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
            decoration: BoxDecoration(
              color: AppColors.backColorList[Random().nextInt(
                AppColors.backColorList.length,
              )],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  task.taskTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  task.taskDesc,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Image.asset(AppAssets.clock, width: 20),
                    const SizedBox(width: 8),
                    Text(
                      task.taskDate,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.perano.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        task.taskType,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color:
                            (task.taskCompleted ? Colors.green : Colors.red)
                                .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        task.taskCompleted ? 'Done' : 'On Going',
                        style: const TextStyle(
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
      );
    },
  );
}

Widget slideLeftBackground() {
  return Container(
    color: Colors.red,
    child: Align(
      // ignore: sort_child_properties_last
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const <Widget>[
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
