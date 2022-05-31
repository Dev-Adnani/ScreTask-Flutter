import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scretask/app/constants/app.assets.dart';
import 'package:scretask/app/routes/app.routes.dart';
import 'package:scretask/presentation/widgets/custom.button.dart';
import 'package:scretask/presentation/widgets/custom.styles.dart';

class DeciderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          reverse: true,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Lottie.asset(AppAssets.welcome),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Task It Out",
                            style: kHeadline,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              "Bring  your tasks,\nManage it from mobile \nand desktop and web.",
                              style: kBodyText,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomButton.customBtnLogin(
                              bgColor: Colors.white,
                              buttonName: 'Register',
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRouter.signUpRoute);
                              },
                              textColor: Colors.black87,
                            ),
                          ),
                          Expanded(
                            child: CustomButton.customBtnLogin(
                              bgColor: Colors.transparent,
                              buttonName: 'Sign In',
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRouter.loginRoute);
                              },
                              textColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
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
