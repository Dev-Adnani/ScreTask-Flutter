import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scretask/app/constants/app.assets.dart';
import 'package:scretask/app/constants/app.colors.dart';
import 'package:scretask/app/routes/app.routes.dart';
import 'package:scretask/core/notifiers/task.notiifer.dart';
import 'package:scretask/core/notifiers/type.notifier.dart';
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
                padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
                width: width,
                child: Column(
                  children: [
                    Container(
                      child: Form(
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
                                  'Select Date : ${myFormat.format(Provider.of<TypeNotifier>(context, listen: true).datex)}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Provider.of<TypeNotifier>(context, listen: false)
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: Text(
                      'Select Type',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ),
                  Container(
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
            child: Container(
              height: 80,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        LoadingDialog.showLoaderDialog(context: context);

                        Provider.of<TaskNotifier>(context, listen: false)
                            .addTask(
                          userId: Provider.of<UserDataNotifier>(context,
                                  listen: false)
                              .getID!,
                          task_title: titleController.text,
                          task_desc: descController.text,
                          task_type:
                              Provider.of<TypeNotifier>(context, listen: false)
                                  .getType,
                          task_date: myFormat.format(
                              Provider.of<TypeNotifier>(context, listen: false)
                                  .datex),
                          context: context,
                        )
                            .whenComplete(() {
                          Navigator.of(context).pushNamed(AppRouter.homeRoute);
                        });
                      }
                    },
                    child: Container(
                      child: Text(
                        'Create Task',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      width: width - 40,
                      decoration: BoxDecoration(
                        color: AppColors.perano,
                        borderRadius: BorderRadius.circular(30),
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
