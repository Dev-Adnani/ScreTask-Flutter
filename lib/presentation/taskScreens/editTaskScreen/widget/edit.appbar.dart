// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scretask/app/routes/app.routes.dart';
import 'package:scretask/core/notifiers/task.notiifer.dart';
import 'package:scretask/presentation/widgets/loading.dialog.dart';
import 'package:scretask/presentation/widgets/snackbar.widget.dart';

AppBar editAppBar({
  required BuildContext context,
  required String taskId,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: const Text(
      'Edit Task',
      style: const TextStyle(
        fontSize: 26,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    automaticallyImplyLeading: false,
    leading: IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(
        Icons.arrow_back_ios,
        size: 20,
        color: Colors.black,
      ),
    ),
    actions: [
      IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
          size: 25,
        ),
        onPressed: () {
          showAlertDialog(context: context, taskId: taskId);
        },
      )
    ],
  );
}

showAlertDialog({
  required BuildContext context,
  required String taskId,
}) {
  Widget cancelButton = TextButton(
    child: const Text(
      "No",
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Colors.blueAccent,
      ),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: const Text(
      "Yes",
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Colors.red,
      ),
    ),
    onPressed: () async {
      LoadingDialog.showLoaderDialog(context: context);
      Provider.of<TaskNotifier>(context, listen: false)
          .deleteTask(taskId: taskId, context: context)
          .whenComplete(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackUtil.stylishSnackBar(text: 'Deleted', context: context),
        );
        Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
      });
    },
  );
  AlertDialog alert = AlertDialog(
    title: const Text(
      "Are You Sure You Want To Delete?",
      style: TextStyle(
        fontSize: 18,
      ),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
