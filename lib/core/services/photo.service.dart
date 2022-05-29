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

  Future selectFile() async {
    file = await FilePicker.platform.pickFiles(
      allowCompression: true,
      type: FileType.image,
    );
    notifyListeners();
  }

  Future upload() async {
    final response = await cloudinary.uploadResource(CloudinaryUploadResource(
        filePath: file!.files.single.path,
        resourceType: CloudinaryResourceType.image,
        folder: 'task-app',
        fileName: file!.files.single.name,
        progressCallback: (count, total) {
          print(
              'Uploading image from file with progress: ${(count / total) * 100}');
        }));

    if (response.isSuccessful) {
      print('Get your image from with ${response.secureUrl}');
    } else {
      print('Nahi Hua');
    }
  }
}
