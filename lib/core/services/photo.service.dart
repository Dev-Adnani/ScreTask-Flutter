import 'dart:async';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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

  Future upload<bool>({required BuildContext context}) async {
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
      return true;
    } else {
      print('Nahi Hua');
      return false;
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
            CircularProgressIndicator(),
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
