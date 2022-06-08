import 'package:flutter/material.dart';
import 'package:scretask/presentation/homeScreen/widgets/home.appbar.dart';
import 'package:scretask/presentation/homeScreen/widgets/home.createTask.dart';
import 'package:scretask/presentation/homeScreen/widgets/home.taskType.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: homeAppBar(context: context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CreateTask(),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Tasks',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: TaskType(),
            )
          ],
        ),
      ),
    );
  }
}
