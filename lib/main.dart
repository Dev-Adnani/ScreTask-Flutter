//Main File
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scretask/app/providers/app.provider.dart';
import 'package:scretask/app/routes/app.routes.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const Lava());
}

class Lava extends StatelessWidget {
  const Lava({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProvider.providers,
      child: const Core(),
    );
  }
}

class Core extends StatelessWidget {
  const Core({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white),
    );

    return MaterialApp(
      title: 'SCRETASK',
      theme: ThemeData(
        fontFamily: 'Averta',
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xffffffff),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.splashRoute,
    );
  }
}
