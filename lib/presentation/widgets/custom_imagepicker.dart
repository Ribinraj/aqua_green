import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class CustomImagePicker {
  final ImagePicker _picker = ImagePicker();
  
  CustomImagePicker();

  Future<File?> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }

  Future<void> showCameraDialog(
    BuildContext context, {
    required Function(File?) onImagePicked,
  }) async {
    final image = await pickImage();
    onImagePicked(image);
  }
}
