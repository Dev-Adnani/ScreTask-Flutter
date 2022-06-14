import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:scretask/app/routes/app.routes.dart';
import 'package:scretask/core/models/taskType.model.dart';
import 'package:scretask/presentation/taskScreens/taskTypeScreen/task.type.screen.dart';
import 'package:scretask/presentation/widgets/snackbar.widget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class TaskType extends StatelessWidget {
  const TaskType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskList = TaskTypeModel.generateTask(context: context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
        itemCount: taskList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: kIsWeb ? 4 : 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => taskList[index].isLast
            ? _buildAddTask(context)
            : _buildTask(
                context,
                taskList[index],
              ),
      ),
    );
  }

  Widget _buildAddTask(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackUtil.stylishSnackBar(
              text: 'Will Be Available Soon', context: context),
        );
      },
      child: DottedBorder(
        padding: const EdgeInsets.all(15),
        radius: const Radius.circular(20),
        borderType: BorderType.RRect,
        dashPattern: const [10, 10],
        color: Colors.grey,
        strokeWidth: 2,
        child: const Center(
          child: Text(
            '+ Add',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTask(BuildContext context, TaskTypeModel task) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRouter.taskTypeRoute,
          arguments: TaskTypeArgs(taskType: task.title!),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: task.bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              task.iconData,
              color: task.iconColor,
              size: 35,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              task.title!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
