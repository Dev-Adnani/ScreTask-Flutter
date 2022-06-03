import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scretask/app/routes/app.routes.dart';
import 'package:scretask/core/notifiers/authentication.notifer.dart';
import 'package:scretask/core/services/photo.service.dart';
import 'package:scretask/core/util/obscure.text.util.dart';
import 'package:scretask/presentation/signupScreen/widget/display.signup.screen.dart';
import 'package:scretask/presentation/widgets/custom.button.dart';
import 'package:scretask/presentation/widgets/custom.text.field.dart';
import 'package:scretask/presentation/widgets/custom.styles.dart';
import 'package:scretask/presentation/widgets/snackbar.widget.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController userSecurityCodeController =
      TextEditingController();
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
                                  hintText: 'Email',
                                  enabled: false,
                                  initialValue:
                                      Provider.of<AuthenticationNotifier>(
                                              context,
                                              listen: false)
                                          .getEmail,
                                  inputType: TextInputType.text,
                                ),
                                CustomTextField.customTextField(
                                  hintText: 'Username',
                                  inputType: TextInputType.text,
                                  textEditingController: userNameController,
                                  validator: (val) =>
                                      val!.isEmpty ? 'Enter a username' : null,
                                ),
                                CustomTextField.customPasswordField(
                                  context: context,
                                  validator: (val) =>
                                      val!.isEmpty ? 'Enter a password' : null,
                                  onTap: () {
                                    Provider.of<ObscureTextUtil>(context,
                                            listen: false)
                                        .toggleObs();
                                  },
                                  textEditingController: userPassController,
                                ),
                                CustomTextField.customTextField(
                                  hintText: 'Security Code',
                                  inputType: TextInputType.number,
                                  maxLength: 4,
                                  textEditingController:
                                      userSecurityCodeController,
                                  validator: (val) => val!.isEmpty
                                      ? 'Enter Security Code'
                                      : null,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DisplayPhotoSignUp(),
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
                                .pushNamed(AppRouter.loginRoute);
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
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (Provider.of<PhotoService>(context, listen: false)
                                  .file ==
                              null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackUtil.stylishSnackBar(
                                text: 'Please Select Profile Pic',
                                context: context,
                              ),
                            );
                          } else {
                            Provider.of<PhotoService>(context, listen: false)
                                .upload(context: context)
                                .whenComplete(() {
                              Provider.of<AuthenticationNotifier>(context,
                                      listen: false)
                                  .createAccount(
                                context: context,
                                username: userNameController.text,
                                secretcodeinput:
                                    userSecurityCodeController.text,
                                userpassword: userPassController.text,
                              );
                            });
                          }
                        }
                      },
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
