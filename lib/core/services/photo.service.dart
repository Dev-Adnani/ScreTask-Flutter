import 'dart:async';
import 'dart:ffi';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:scretask/app/constants/app.const.dart';

class PhotoService with ChangeNotifier {
  final cloudinary = Cloudinary.full(
    apiKey: AppConst.apiKey,
    apiSecret: AppConst.apiSecret,
    cloudName: AppConst.cloudName,
  );

  FilePickerResult? file;
  String? photo_url;

  Future selectFile() async {
    file = await FilePicker.platform.pickFiles(
      allowCompression: true,
      type: FileType.image,
    );
    notifyListeners();
  }

  Future upload({required BuildContext context}) async {
    final response = await cloudinary.uploadResource(
      CloudinaryUploadResource(
        filePath: file!.files.single.path,
        resourceType: CloudinaryResourceType.image,
        folder: 'task-app',
        fileName: file!.files.single.name,
        progressCallback: (count, total) {
          showAlertDialog(context: context, count: count, total: total);
          Timer(
            Duration(seconds: 2),
            () {
              Navigator.of(context).pop();
            },
          );
        },
      ),
    );

    if (response.isSuccessful) {
      print('Get your image from with ${response.secureUrl}');
      photo_url = response.secureUrl;
      notifyListeners();
    } else {
      print('Nahi Hua');
    }
  }

  //Dialog
  showAlertDialog({
    required BuildContext context,
    required int count,
    required int total,
  }) {
    AlertDialog alert = AlertDialog(
      content: Container(
        height: 150,
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Image Uploading'),
            SizedBox(
              height: 10,
            ),
            CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 5.0,
              percent: 1.0,
              center: Text("${(count / total) * 100}"),
              progressColor: Colors.green,
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
