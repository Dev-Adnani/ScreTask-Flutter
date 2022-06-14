import 'package:date_picker_timeline/date_picker_timeline.dart';
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
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 100,
                child: DatePicker(
                  DateTime.now(),
                  daysCount: 30,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.black,
                  selectedTextColor: Colors.white,
                ),
              ),
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
                        var dSnapshot = snapshot.data as List;
                        return taskTile(snapshot: dSnapshot, context: context);
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
