import 'package:scretask/core/notifiers/home.switch.notifer.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProvider {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => HomeSwitchNotifier()),
  ];
}
