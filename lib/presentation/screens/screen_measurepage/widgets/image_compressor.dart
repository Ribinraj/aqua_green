import 'dart:convert';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class ImageProcessor {
  static final _uuid = Uuid();

  /// Process a single image - compress and convert to base64
  static Future<String> processImage(File imageFile) async {
    File? compressedFile;
    try {
      // Compress the image
      compressedFile = await compressImage(imageFile);

      // Convert to base64
      final base64String = await convertToBase64(compressedFile);

      return base64String;
    } catch (e) {
      throw Exception('Failed to process image: $e');
    } finally {
      // Cleanup temporary compressed file
      if (compressedFile != null && await compressedFile.exists()) {
        await compressedFile.delete();
      }
    }
  }

  /// Compress image while maintaining reasonable quality
  static Future<File> compressImage(File file) async {
    try {
      // Get temporary directory
      final tempDir = await getTemporaryDirectory();

      // Create unique filename for compressed image
      final uniqueId = _uuid.v4();
      final fileName = '${path.basenameWithoutExtension(file.path)}_$uniqueId';
      final targetPath = path.join(tempDir.path, '${fileName}_compressed.jpg');

      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 70, // Adjust quality (0-100)
        format: CompressFormat.jpeg,
        // Optional additional parameters for better control
        minWidth: 1024, // Minimum width
        minHeight: 1024, // Minimum height
        rotate: 0, // Rotation angle if needed
      );

      if (result == null) {
        throw Exception('Failed to compress image');
      }

      return File(result.path);
    } catch (e) {
      throw Exception('Error during image compression: $e');
    }
  }

  /// Convert file to base64
  static Future<String> convertToBase64(File file) async {
    try {
      List<int> imageBytes = await file.readAsBytes();
      return base64Encode(imageBytes);
    } catch (e) {
      throw Exception('Error converting to base64: $e');
    }
  }

  /// Process multiple images
  static Future<List<String>> processMultipleImages(List<File> images) async {
    try {
      List<String> processedImages = [];

      for (var image in images) {
        String processedImage = await processImage(image);
        processedImages.add(processedImage);
      }

      return processedImages;
    } catch (e) {
      throw Exception('Error processing multiple images: $e');
    }
  }

  /// Generate a unique filename for an image with proper extension
  static String generateImageName(String pictureType) {
    final timestamp = DateTime.now().toIso8601String();
    final uniqueId = _uuid.v4().substring(0, 8);
    return '${pictureType}_${timestamp}_$uniqueId.jpg';
  }
}
// import 'dart:convert';
// import 'dart:io';
// import 'package:uuid/uuid.dart';

// class ImageProcessor {
//   static final _uuid = Uuid();

//   /// Process a single image - convert to base64
//   static Future<String> processImage(File imageFile) async {
//     try {
//       // Convert to base64
//       final base64String = await convertToBase64(imageFile);
//       return base64String;
//     } catch (e) {
//       throw Exception('Failed to process image: $e');
//     }
//   }

//   /// Convert file to base64
//   static Future<String> convertToBase64(File file) async {
//     try {
//       List<int> imageBytes = await file.readAsBytes();
//       return base64Encode(imageBytes);
//     } catch (e) {
//       throw Exception('Error converting to base64: $e');
//     }
//   }

//   /// Process multiple images
//   static Future<List<String>> processMultipleImages(List<File> images) async {
//     try {
//       List<String> processedImages = [];
      
//       for (var image in images) {
//         String processedImage = await processImage(image);
//         processedImages.add(processedImage);
//       }

//       return processedImages;
//     } catch (e) {
//       throw Exception('Error processing multiple images: $e');
//     }
//   }

//   /// Generate a unique filename for an image with proper extension
//   static String generateImageName(String pictureType) {
//     final timestamp = DateTime.now().toIso8601String();
//     final uniqueId = _uuid.v4().substring(0, 8);
//     return '${pictureType}_${timestamp}_$uniqueId.jpg';
//   }
// }