import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scretask/core/notifiers/authentication.notifer.dart';
import 'package:scretask/presentation/widgets/custom.button.dart';
import 'package:scretask/presentation/widgets/custom.text.field.dart';
import 'package:scretask/presentation/widgets/custom.styles.dart';
import 'package:scretask/presentation/widgets/loading.dialog.dart';

class VerificationScreen extends StatelessWidget {
  final TextEditingController userEmailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _userEmail() {
      if (_formKey.currentState!.validate()) {
        LoadingDialog.showLoaderDialog(context: context);
        Provider.of<AuthenticationNotifier>(context, listen: false)
            .sendEmail(useremail: userEmailController.text, context: context);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: CustomScrollView(
          reverse: true,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Hey 😉",
                            style: kHeadline,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Happy To Have You!",
                            style: kBodyText2,
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                CustomTextField.customTextField(
                                  hintText: 'Email',
                                  inputType: TextInputType.text,
                                  textEditingController: userEmailController,
                                  validator: (val) =>
                                      !RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                              .hasMatch(val!)
                                          ? 'Enter an email'
                                          : null,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomButton.customBtnLogin(
                            buttonName: 'Send Email',
                            onTap: () {
                              _userEmail();
                            },
                            bgColor: Colors.black,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
