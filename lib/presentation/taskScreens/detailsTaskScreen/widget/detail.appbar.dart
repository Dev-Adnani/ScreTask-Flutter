import 'package:flutter/material.dart';

AppBar detailAppBar({required BuildContext context, required String taskType}) {
  return AppBar(
    toolbarHeight: 50,
    backgroundColor: Colors.white,
    leading: IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(
        Icons.arrow_back_ios,
        size: 20,
        color: Colors.black,
      ),
    ),
    actions: [
      Icon(
        Icons.more_vert,
        size: 35,
        color: Colors.black,
      ),
    ],
    title: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$taskType Task',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
