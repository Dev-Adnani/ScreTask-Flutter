//Main File
// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scretask/app/providers/app.provider.dart';
import 'package:scretask/app/routes/app.routes.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Lava());
  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => Lava(),
  // ));
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
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
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
