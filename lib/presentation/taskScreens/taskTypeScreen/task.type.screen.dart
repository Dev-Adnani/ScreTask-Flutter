import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scretask/core/notifiers/task.notiifer.dart';
import 'package:scretask/core/notifiers/user.data.notifier.dart';
import 'package:scretask/presentation/taskScreens/noTaskScreen/no.tasks.screen.dart';
import 'package:scretask/presentation/taskScreens/taskTypeScreen/widget/task.tile.dart';
import 'package:scretask/presentation/taskScreens/taskTypeScreen/widget/task.type.appbar.dart';

class TaskTypeScreen extends StatelessWidget {
  final TaskTypeArgs taskTypeArgs;
  const TaskTypeScreen({Key? key, required this.taskTypeArgs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: detailAppBar(
          context: context,
          taskType: taskTypeArgs.taskType,
        ),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<TaskNotifier>(
                builder: (context, notifier, _) {
                  return FutureBuilder(
                    future: notifier.getTaskType(
                      userId:
                          Provider.of<UserDataNotifier>(context, listen: false)
                              .getID!,
                      type: taskTypeArgs.taskType,
                      context: context,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return loadingData();
                      } else if (!snapshot.hasData) {
                        return Center(
                          child: noTaskScreen(type: taskTypeArgs.taskType),
                        );
                      } else {
                        var _snapshot = snapshot.data as List;
                        return taskTile(snapshot: _snapshot, context: context);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskTypeArgs {
  final String taskType;
  const TaskTypeArgs({required this.taskType});
}
