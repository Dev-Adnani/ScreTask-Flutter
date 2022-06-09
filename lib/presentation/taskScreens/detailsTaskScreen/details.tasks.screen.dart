import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scretask/core/notifiers/task.notiifer.dart';
import 'package:scretask/core/notifiers/user.data.notifier.dart';
import 'package:scretask/presentation/taskScreens/detailsTaskScreen/widget/detail.appbar.dart';
import 'package:scretask/presentation/taskScreens/detailsTaskScreen/widget/task.data.dart';
import 'package:scretask/presentation/taskScreens/noTaskScreen/no.tasks.screen.dart';

class DetailsTaskScreen extends StatelessWidget {
  final DetailsTasksArgs detailsTasksArgs;
  const DetailsTaskScreen({Key? key, required this.detailsTasksArgs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: detailAppBar(
          context: context,
          taskType: detailsTasksArgs.taskType,
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
                        userId: Provider.of<UserDataNotifier>(context,
                                listen: false)
                            .getID!,
                        type: detailsTasksArgs.taskType,
                        context: context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (!snapshot.hasData) {
                        return Center(
                          child: noTaskScreen(type: detailsTasksArgs.taskType),
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

class DetailsTasksArgs {
  final String taskType;
  const DetailsTasksArgs({required this.taskType});
}
