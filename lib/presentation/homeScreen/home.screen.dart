import 'package:flutter/material.dart';
import 'package:scretask/app/routes/app.routes.dart';
import 'package:scretask/presentation/homeScreen/widgets/home.bottomNav.dart';
import 'package:scretask/presentation/homeScreen/widgets/home.createTask.dart';
import 'package:scretask/presentation/homeScreen/widgets/home.appbar.dart';
import 'package:scretask/presentation/homeScreen/widgets/home.taskType.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: homeAppBar(),
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
      bottomNavigationBar: homeBottomNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context).pushNamed(AppRouter.createTaskRoute);
        },
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
    );
  }
}
