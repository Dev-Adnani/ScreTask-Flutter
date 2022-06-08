import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scretask/app/constants/app.assets.dart';
import 'package:scretask/app/constants/app.const.dart';
import 'package:scretask/app/routes/app.routes.dart';
import 'package:scretask/core/services/local.auth.service.dart';
import 'package:scretask/presentation/widgets/snackbar.widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  void _initiateCache({required BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString(AppConst.splashKey);
    var d_auth = await Provider.of<LocalAuthService>(context, listen: false)
        .authenticate();
    if (d_auth) {
      if (action == null) {
        Navigator.of(context).pushReplacementNamed(AppRouter.deciderRoute);
      } else {
        Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
          text: 'Please Complete Biometric Auth',
          context: context,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Scre Task',
              style: TextStyle(
                fontSize: 42,
                color: Colors.black,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: IconButton(
              icon: Image.asset(
                AppAssets.fprint,
              ),
              onPressed: () {
                _initiateCache(context: context);
              },
              iconSize: 130,
            ),
          ),
        ],
      )),
    );
  }
}
