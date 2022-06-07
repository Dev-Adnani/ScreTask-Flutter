import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scretask/app/routes/app.routes.dart';
import 'package:scretask/core/api/user.api.dart';
import 'package:scretask/core/models/user.data.model.dart';
import 'package:scretask/core/notifiers/authentication.notifer.dart';
import 'package:scretask/presentation/widgets/snackbar.widget.dart';

class UserDataNotifier with ChangeNotifier {
  final UserDataAPI _dataAPI = UserDataAPI();

  String? _email;
  String? get getEmail => _email;

  String? _name;
  String? get getName => _name;

  String? _id;
  String? get getID => _id;

  String? _photo;
  String? get getPhoto => _photo;

  Future<bool> decodeUserData({
    required BuildContext context,
  }) async {
    var userData = await _dataAPI.decodeUserData(context: context);
    var response = userDataModelFromJson(userData);
    bool received = response.received;
    if (!received) {
      Provider.of<AuthenticationNotifier>(context, listen: false).userjwt =
          null;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
          text: "Sign In Expired",
          context: context,
        ),
      );
      Navigator.of(context).pushReplacementNamed(AppRouter.deciderRoute);
      return false;
    } else {
      var userData = response.data!;
      _email = userData.email;
      _id = userData.id;
      _name = userData.name;
      _photo = userData.photo;
      notifyListeners();
      return true;
    }
  }
}
