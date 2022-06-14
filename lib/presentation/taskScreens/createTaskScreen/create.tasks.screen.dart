import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scretask/app/constants/app.assets.dart';
import 'package:scretask/app/constants/app.colors.dart';
import 'package:scretask/app/routes/app.routes.dart';
import 'package:scretask/core/notifiers/task.notiifer.dart';
import 'package:scretask/core/notifiers/task.data.notifier.dart';
import 'package:scretask/core/notifiers/user.data.notifier.dart';
import 'package:scretask/presentation/taskScreens/createTaskScreen/widget/create.appbar.dart';
import 'package:scretask/presentation/taskScreens/createTaskScreen/widget/select.type.dart';
import 'package:scretask/presentation/widgets/custom.text.field.dart';
import 'package:scretask/presentation/widgets/loading.dialog.dart';

class CreateTaskScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  CreateTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var myFormat = DateFormat('d-MM-yyyy');
    return Scaffold(
      appBar: createAppBar(context: context),
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
                                  'Select Date : ${myFormat.format(Provider.of<TaskDataNotifier>(context, listen: true).datex)}',
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
                            Provider.of<TaskDataNotifier>(context, listen: false)
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
                            .addTask(
                          userId: Provider.of<UserDataNotifier>(context,
                                  listen: false)
                              .getID!,
                          task_title: titleController.text,
                          task_desc: descController.text,
                          task_type:
                              Provider.of<TaskDataNotifier>(context, listen: false)
                                  .getType,
                          task_date: myFormat.format(
                              Provider.of<TaskDataNotifier>(context, listen: false)
                                  .datex),
                          context: context,
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
                      child: const Text(
                        'Create Task',
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
