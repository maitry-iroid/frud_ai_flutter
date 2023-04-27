import 'dart:io';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/base_text.dart';
import 'math_utils.dart';

class ImagePickerUtils {
  final picker = ImagePicker();
  final int imageQuality = 50;
  bool cameraPermissionPermanentlyDenied = false;
  bool galleryPermissionPermanentlyDenied = false;

  Future<String?> pickImage({required ImageSource imageSource}) async {
    try {
      XFile? pickedImage;

      if (imageSource == ImageSource.gallery) {
        var permission = await checkAndRequestStoragePermissions();
        print(permission);
        if (permission) {
          pickedImage = await picker.pickImage(
            source: imageSource,
            // maxWidth: imageMaxWidth,
            // maxHeight: imageMaxHeight,
            imageQuality: imageQuality,
          );
        } else {
          if (galleryPermissionPermanentlyDenied) {
            _showPermissionAlertDialog(imageSource: imageSource);
          }
        }
      } else if (imageSource == ImageSource.camera) {
        var permission = await checkAndRequestCameraPermissions();
        print(permission);
        if (permission) {
          pickedImage = await picker.pickImage(
            source: imageSource,
            // maxWidth: imageMaxWidth,
            // maxHeight: imageMaxHeight,
            imageQuality: imageQuality,
          );
        } else {
          if (cameraPermissionPermanentlyDenied) {
            _showPermissionAlertDialog(imageSource: imageSource);
          }
        }
      }

      if (pickedImage != null) {
        //profileImagePath.value = pickedImage.path;
        //UserMoreInfo.userInfoModel.document = profileImagePath.value;

        File imageFile = File(pickedImage.path);

        print('File path = ${pickedImage.path}');
        print(
            'File size = ${(imageFile.lengthSync() / 1024).toStringAsFixed(2)} KB');
      }

      return pickedImage?.path;
    } catch (ex) {
      print('Error ===> ${ex.toString()}');
      return null;
    }
  }

  Future<bool> checkAndRequestCameraPermissions() async {
    PermissionStatus permission = await Permission.camera.status;

    if (permission != PermissionStatus.granted) {
      var permissionStatus = await Permission.camera.request();
      if (permissionStatus.isGranted) {
        return true;
      } else if (permissionStatus.isPermanentlyDenied) {
        cameraPermissionPermanentlyDenied = true;
        return false;
      } else {
        return false;
      }
    } else if (permission == PermissionStatus.permanentlyDenied) {
      cameraPermissionPermanentlyDenied = true;
      return false;
    } else {
      return true;
    }
  }

  Future<bool> checkAndRequestStoragePermissions() async {
    PermissionStatus permission = await Permission.storage.status;

    if (permission != PermissionStatus.granted) {
      var permissionStatus = await Permission.storage.request();
      if (permissionStatus.isGranted) {
        return true;
      } else if (permissionStatus.isPermanentlyDenied) {
        galleryPermissionPermanentlyDenied = true;
        return false;
      } else {
        return false;
      }
    } else if (permission == PermissionStatus.permanentlyDenied) {
      galleryPermissionPermanentlyDenied = true;
      return false;
    } else {
      return true;
    }
  }

  Future<void> _showPermissionAlertDialog(
      {required ImageSource imageSource}) async {
    String source = imageSource == ImageSource.camera ? 'Camera' : 'Gallery';

    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius.all(
              SmoothRadius(
                cornerRadius: getSize(20),
                cornerSmoothing: 1,
              ),
            ),
          ),
          title: BaseText(
            text: 'Permission Denied!',
            fontWeight: FontWeight.w600,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                  text:
                      'Unable to open $source. Go to Settings > Permissions, then allow following permissions and try again:'),
              SizedBox(
                height: getSize(20),
              ),
              Row(
                children: [
                  imageSource == ImageSource.camera
                      ? Icon(Icons.camera_alt_outlined)
                      : Icon(Icons.photo_library_sharp),
                  SizedBox(
                    width: getSize(10),
                  ),
                  BaseText(
                    text: imageSource == ImageSource.camera
                        ? 'Camera'
                        : 'Files and media',
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: BaseText(
                text: 'Cancel',
                fontWeight: FontWeight.w600,
                textColor: Colors.blueAccent,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: BaseText(
                text: 'Open Settings',
                fontWeight: FontWeight.w600,
                textColor: Colors.blueAccent,
              ),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
