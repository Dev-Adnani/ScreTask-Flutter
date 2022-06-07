import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:scretask/core/notifiers/authentication.notifer.dart';
import 'package:scretask/core/notifiers/user.data.notifier.dart';
import 'package:scretask/core/services/local.auth.service.dart';
import 'package:scretask/core/services/photo.service.dart';
import 'package:scretask/core/util/obscure.text.util.dart';

class AppProvider {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => LocalAuthService()),
    ChangeNotifierProvider(create: (_) => ObscureTextUtil()),
    ChangeNotifierProvider(create: (_) => PhotoService()),
    ChangeNotifierProvider(create: (_) => AuthenticationNotifier()),
    ChangeNotifierProvider(create: (_) => UserDataNotifier()),
  ];
}
