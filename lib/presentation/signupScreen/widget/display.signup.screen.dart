import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scretask/core/services/photo.service.dart';
import 'package:scretask/presentation/widgets/custom.styles.dart';

class DisplayPhotoSignUp extends StatelessWidget {
  const DisplayPhotoSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Provider.of<PhotoService>(context, listen: true).file == null
              ? null
              : Image.file(
                  height: 60,
                  width: 60,
                  File(
                    Provider.of<PhotoService>(context, listen: true)
                        .file!
                        .files
                        .first
                        .path!,
                  ),
                ),
        ),
        const SizedBox(
          width: 25,
        ),
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width / 1.5,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(18),
          ),
          child: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith(
                (states) => Colors.black12,
              ),
            ),
            onPressed: () {
              Provider.of<PhotoService>(context, listen: false).selectFile();
            },
            child: Text(
              'Select Profile Pic',
              style: kButtonText.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
