import 'package:flutter/material.dart';
import 'package:scretask/presentation/taskScreens/detailsTaskScreen/widget/detail.appbar.dart';
import 'package:scretask/presentation/taskScreens/detailsTaskScreen/widget/task.data.dart';

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
            children: [
              TaskData(),
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
