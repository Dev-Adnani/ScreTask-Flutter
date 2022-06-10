import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scretask/app/routes/app.routes.dart';
import 'package:scretask/core/notifiers/user.data.notifier.dart';
import 'package:scretask/presentation/aboutScreen/about.user.dart';
import 'package:scretask/presentation/homeScreen/widgets/home.bottomNav.dart';
import 'package:scretask/presentation/homeScreen/widgets/home.section.dart';
import 'package:scretask/presentation/widgets/loading.dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<UserDataNotifier>(context, listen: false)
        .decodeUserData(context: context);
    super.initState();
  }

  int pageIndex = 0;
  final PageController homePageController = PageController();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring:
          Provider.of<UserDataNotifier>(context, listen: true).getAllowTouch
              ? false
              : true,
      child: Scaffold(
        body: PageView(
          controller: homePageController,
          children: [
            // Provider.of<UserDataNotifier>(context, listen: true).getAllowTouch
            //     ? LoadingDialog.showLoaderDialog(context: context)
            //     : null,
            HomeSection(),
            AboutScreen(),
          ],
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (page) {
            setState(() {
              pageIndex = page;
            });
          },
        ),
        bottomNavigationBar: homeBottomNav(
          controller: homePageController,
          index: pageIndex,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.of(context).pushNamed(AppRouter.createTaskRoute);
          },
          child: Icon(
            Icons.add,
            size: 35,
          ),
        ),
      ),
    );
  }
}
