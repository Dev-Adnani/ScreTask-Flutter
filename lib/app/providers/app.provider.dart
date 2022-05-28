import 'package:scretask/core/notifiers/home.switch.notifer.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:scretask/core/notifiers/obs.notifier.dart';

class AppProvider {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => HomeSwitchNotifier()),
    ChangeNotifierProvider(create: (_) => ObscureTextState()),
  ];
}
