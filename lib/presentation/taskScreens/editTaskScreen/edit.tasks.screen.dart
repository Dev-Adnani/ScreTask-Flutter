// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scretask/app/constants/app.assets.dart';
import 'package:scretask/app/constants/app.colors.dart';
import 'package:scretask/app/routes/app.routes.dart';
import 'package:scretask/core/notifiers/task.data.notifier.dart';
import 'package:scretask/core/notifiers/task.notiifer.dart';
import 'package:scretask/presentation/taskScreens/createTaskScreen/widget/select.type.dart';
import 'package:scretask/presentation/taskScreens/editTaskScreen/widget/edit.appbar.dart';
import 'package:scretask/presentation/widgets/custom.text.field.dart';
import 'package:scretask/presentation/widgets/loading.dialog.dart';

class EditTaskScreen extends StatefulWidget {
  final EditTaskArgs editTaskArgs;

  const EditTaskScreen({Key? key, required this.editTaskArgs}) : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  bool status = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.editTaskArgs.task_title;
    descController.text = widget.editTaskArgs.task_desc;
    status = widget.editTaskArgs.taskStatus;
    if (widget.editTaskArgs.task_type == "Work") {
      Provider.of<TaskDataNotifier>(context, listen: false).editable_work();
    } else if (widget.editTaskArgs.task_type == "Personal") {
      Provider.of<TaskDataNotifier>(context, listen: false).editable_personal();
    } else if (widget.editTaskArgs.task_type == "Health") {
      Provider.of<TaskDataNotifier>(context, listen: false).editable_health();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var myFormat = DateFormat('d-MM-yyyy');
    return Scaffold(
      appBar: editAppBar(context: context, taskId: widget.editTaskArgs.task_id),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                width: width,
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField.customTextField(
                            hintText: 'Title',
                            textEditingController: titleController,
                            minLines: 1,
                          ),
                          CustomTextField.customTextField(
                            hintText: 'Description',
                            textEditingController: descController,
                            minLines: 1,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(AppAssets.clock, width: 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 250),
                                child: Text(
                                  'Select Date : ${widget.editTaskArgs.task_date}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Provider.of<TaskDataNotifier>(context,
                                    listen: false)
                                .selectDate(context: context);
                          },
                          icon: const Icon(Icons.edit),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: Text(
                      'Select Type',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width,
                    child: selectType(
                      context: context,
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Task Status',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        FlutterSwitch(
                          width: 70.0,
                          height: 30.0,
                          valueFontSize: 25.0,
                          toggleSize: 20.0,
                          value: status,
                          borderRadius: 30.0,
                          padding: 8.0,
                          onToggle: (val) {
                            setState(() {
                              status = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 80,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (titleController.text.isNotEmpty &&
                          descController.text.isNotEmpty) {
                        LoadingDialog.showLoaderDialog(context: context);
                        Provider.of<TaskNotifier>(context, listen: false)
                            .editTask(
                          task_id: widget.editTaskArgs.task_id,
                          task_title: titleController.text,
                          task_desc: descController.text,
                          task_type: Provider.of<TaskDataNotifier>(context,
                                  listen: false)
                              .getType,
                          task_date: myFormat.format(
                              Provider.of<TaskDataNotifier>(context,
                                      listen: false)
                                  .datex),
                          context: context,
                          task_completed: status,
                        )
                            .whenComplete(() {
                          Navigator.of(context).pushNamed(AppRouter.homeRoute);
                        });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      width: width - 40,
                      decoration: BoxDecoration(
                        color: AppColors.perano,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child:   const Text(
                        'Edit Task',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class EditTaskArgs {
  final String task_id;
  final String task_title;
  final String task_desc;
  final String task_type;
  final String task_date;
  final bool taskStatus;

  EditTaskArgs({
    required this.task_id,
    required this.task_title,
    required this.task_desc,
    required this.task_type,
    required this.task_date,
    required this.taskStatus,
  });
}
