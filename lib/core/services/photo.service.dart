// ignore_for_file: non_constant_identifier_names

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
        progressCallback: (count, total) {},
      ),
    );

    if (response.isSuccessful) {
      photo_url = response.secureUrl;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
