import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:scretask/core/models/taskType.model.dart';
import 'package:scretask/presentation/widgets/snackbar.widget.dart';

class TaskType extends StatelessWidget {
  TaskType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskList = TaskTypeModel.generateTask(context: context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
        itemCount: taskList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
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
        padding: EdgeInsets.all(15),
        radius: Radius.circular(20),
        borderType: BorderType.RRect,
        dashPattern: [10, 10],
        color: Colors.grey,
        strokeWidth: 2,
        child: Center(
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
      onTap: task.callback,
      child: Container(
        padding: EdgeInsets.all(15),
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
            SizedBox(
              height: 20,
            ),
            Text(
              task.title!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                _buildTaskStatus(
                    task.btnColor!, task.iconColor!, '${task.left} Left'),
                SizedBox(
                  width: 3,
                ),
                _buildTaskStatus(
                    Colors.white, task.iconColor!, '${task.left} Done'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTaskStatus(Color bgColor, Color txtColor, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: txtColor,
        ),
      ),
    );
  }
}
