import 'dart:convert';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';


class ImageProcessor {
  // Compress image and convert to base64
  static Future<String> processImage(File imageFile) async {
    // Compress the image
    final compressedImage = await compressImage(imageFile);
    
    // Convert to base64
    final base64String = await convertToBase64(compressedImage);
    
    return base64String;
  }

  // Compress image while maintaining reasonable quality
  static Future<File> compressImage(File file) async {
    final String targetPath = file.path.replaceAll(
      RegExp(r'(\.[^\.]*$)'),
      '_compressed.jpg',
    );

    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 70, // Adjust quality (0-100)
      format: CompressFormat.jpeg,
    );

    return File(result!.path);
  }

  // Convert file to base64
  static Future<String> convertToBase64(File file) async {
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  }

  // Process multiple images
  static Future<List<String>> processMultipleImages(List<File> images) async {
    List<String> processedImages = [];
    
    for (var image in images) {
      String processedImage = await processImage(image);
      processedImages.add(processedImage);
    }
    
    return processedImages;
  }
}