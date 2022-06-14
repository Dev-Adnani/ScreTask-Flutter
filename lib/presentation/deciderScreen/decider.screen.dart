import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scretask/app/constants/app.assets.dart';
import 'package:scretask/app/routes/app.routes.dart';
import 'package:scretask/presentation/widgets/custom.button.dart';
import 'package:scretask/presentation/widgets/custom.styles.dart';

class DeciderScreen extends StatelessWidget {
  const DeciderScreen({Key? key}) : super(key: key);

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
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Lottie.asset(AppAssets.welcome),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Task It Out",
                            style: kHeadline,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: const Text(
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
                                    .pushNamed(AppRouter.verificationRoute);
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
