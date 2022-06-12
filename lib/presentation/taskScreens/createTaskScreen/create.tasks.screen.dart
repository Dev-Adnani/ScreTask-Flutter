import 'package:flutter/material.dart';
import 'package:scretask/app/constants/app.colors.dart';
import 'package:scretask/presentation/taskScreens/createTaskScreen/widget/create.appbar.dart';
import 'package:scretask/presentation/widgets/custom.text.field.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: createAppBar(context: context),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
            width: width,
            child: Column(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField.customTextField(hintText: 'Title'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: CustomTextField.customTextField(
                              hintText: 'Date',
                            ),
                          ),
                        ],
                      ),
                      CustomTextField.customTextField(
                        hintText: 'Description',
                        minLines: 3,
                        maxLines: 3,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 80,
            width: width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    print('ch');
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
        ],
      ),
    );
  }
}
