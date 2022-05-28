import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scretask/app/routes/app.routes.dart';
import 'package:scretask/core/notifiers/obs.notifier.dart';
import 'package:scretask/presentation/widgets/custom.button.dart';
import 'package:scretask/presentation/widgets/custom.text.field.dart';
import 'package:scretask/presentation/widgets/custom.styles.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userPassController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 24,
            color: Colors.black,
          ),
        ),
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
                          Text(
                            "Register",
                            style: kHeadline,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Create new account to get started.",
                            style: kBodyText2,
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                CustomTextField.customTextField(
                                  hintText: 'Username',
                                  inputType: TextInputType.text,
                                  textEditingController: userNameController,
                                ),
                                CustomTextField.customTextField(
                                  hintText: 'Email',
                                  inputType: TextInputType.text,
                                  textEditingController: userEmailController,
                                ),
                                CustomTextField.customPasswordField(
                                  context: context,
                                  onTap: () {
                                    Provider.of<ObscureTextState>(context,
                                            listen: false)
                                        .toggleObs();
                                  },
                                  textEditingController: userPassController,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: kBodyText,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(AppRouter.signUpRoute);
                          },
                          child: Text(
                            'Sign In',
                            style: kBodyText.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton.customBtnLogin(
                      buttonName: 'Register',
                      onTap: () {},
                      bgColor: Colors.black,
                      textColor: Colors.white,
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
