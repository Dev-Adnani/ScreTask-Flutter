import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:scretask/core/services/photo.service.dart';
import 'package:scretask/core/util/obs.util.dart';

class AppProvider {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => ObscureTextState()),
    ChangeNotifierProvider(create: (_) => PhotoService()),
  ];
}
