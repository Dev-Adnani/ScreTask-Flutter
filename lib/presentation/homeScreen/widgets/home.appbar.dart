import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scretask/core/notifiers/authentication.notifer.dart';
import 'package:scretask/core/notifiers/user.data.notifier.dart';

AppBar homeAppBar({required BuildContext context}) {
  var data = Provider.of<UserDataNotifier>(context, listen: true);
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    automaticallyImplyLeading: false,
    title: Row(
      children: [
        Container(
          height: 45,
          width: 45,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              data.getPhoto != null
                  ? data.getPhoto!
                  : "https://www.citypng.com/public/uploads/preview/loading-load-icon-transparent-png-11639609114lctjenyas8.png",
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Hi, ${data.getName != null ? data.getName : "Loading"}!',
          style: TextStyle(
            fontSize: 26,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    actions: [
      IconButton(
        icon: Icon(
          Icons.more_vert,
          color: Colors.black,
          size: 32,
        ),
        onPressed: () {
          showMenu(
              context: context,
              position: const RelativeRect.fromLTRB(300.0, 70.0, 0, 0),
              items: [
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: () {
                      showAlertDialog(context: context);
                    },
                    icon: Icon(Icons.logout_sharp, color: Colors.black),
                    label: Text(
                      'Logout?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ]);
        },
      )
    ],
  );
}

showAlertDialog({
  required BuildContext context,
}) {
  Widget cancelButton = TextButton(
    child: const Text(
      "No",
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Colors.blueAccent,
      ),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: const Text(
      "Yes",
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Colors.red,
      ),
    ),
    onPressed: () async {
      Provider.of<AuthenticationNotifier>(context, listen: false)
          .userLogout(context: context);
    },
  );
  AlertDialog alert = AlertDialog(
    title: const Text(
      "Are You Sure You Want To Logout ?",
      style: TextStyle(
        fontSize: 18,
      ),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
