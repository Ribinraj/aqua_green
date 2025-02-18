import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:aqua_green/presentation/blocs/image_picker/image_picker_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

// class ImageProcessor {
//   static final _uuid = Uuid();

//   /// Process a single image - compress and convert to base64
//   static Future<String> processImage(File imageFile) async {
//     File? compressedFile;
//     try {
//       // Compress the image
//       compressedFile = await compressImage(imageFile);

//       // Convert to base64
//       final base64String = await convertToBase64(compressedFile);

//       return base64String;
//     } catch (e) {
//       throw Exception('Failed to process image: $e');
//     } finally {
//       // Cleanup temporary compressed file
//       if (compressedFile != null && await compressedFile.exists()) {
//         await compressedFile.delete();
//       }
//     }
//   }

//   /// Compress image while maintaining reasonable quality
//   static Future<File> compressImage(File file) async {
//     try {
//       // Get temporary directory
//       final tempDir = await getTemporaryDirectory();

//       // Create unique filename for compressed image
//       final uniqueId = _uuid.v4();
//       final fileName = '${path.basenameWithoutExtension(file.path)}_$uniqueId';
//       final targetPath = path.join(tempDir.path, '${fileName}_compressed.jpg');

//       final result = await FlutterImageCompress.compressAndGetFile(
//         file.absolute.path,
//         targetPath,
//         quality: 70, // Adjust quality (0-100)
//         format: CompressFormat.jpeg,
//         // Optional additional parameters for better control
//         minWidth: 1024, // Minimum width
//         minHeight: 1024, // Minimum height
//         rotate: 0, // Rotation angle if needed
//       );

//       if (result == null) {
//         throw Exception('Failed to compress image');
//       }

//       return File(result.path);
//     } catch (e) {
//       throw Exception('Error during image compression: $e');
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
///////////////////////
class ImageProcessor {
  static final _uuid = Uuid();

  /// Compress image with optimized settings based on file size
  static Future<File> compressImage(File file) async {
    try {
      // Get temporary directory
      final tempDir = await getTemporaryDirectory();
      final uniqueId = _uuid.v4();
      final targetPath = path.join(tempDir.path, '${uniqueId}_compressed.jpg');

      // Determine compression settings based on file size
      final fileSize = await file.length();
      int quality = 70;
      int minWidth = 1024;
      int minHeight = 1024;

      // Adjust quality and dimensions for larger files
      if (fileSize > 10 * 1024 * 1024) {
        // > 10MB
        quality = 60;
        minWidth = 800;
        minHeight = 800;
      }

      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: quality,
        minWidth: minWidth,
        minHeight: minHeight,
        format: CompressFormat.jpeg,
        rotate: 0,
      );

      if (result == null) {
        throw Exception('Failed to compress image');
      }

      // Create new file from compressed result
      final compressedFile = File(result.path);

      // Verify compression was successful
      if (!await compressedFile.exists()) {
        throw Exception('Compressed file not found');
      }

      return compressedFile;
    } catch (e) {
      throw Exception('Error during image compression: $e');
    }
  }

  /// Convert file to base64 with error handling
  static Future<String> convertToBase64(File file) async {
    try {
      if (!await file.exists()) {
        throw Exception('File does not exist');
      }

      final bytes = await file.readAsBytes();
      if (bytes.isEmpty) {
        throw Exception('File is empty');
      }

      return base64Encode(bytes);
    } catch (e) {
      throw Exception('Error converting to base64: $e');
    }
  }

  /// Generate unique filename for an image
  static String generateImageName(String pictureType) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final uniqueId = _uuid.v4().substring(0, 8);
    return '${pictureType}_${timestamp}_$uniqueId.jpg';
  }

  /// Process multiple images in sequence
  static Future<List<ProcessedImageData>> processMultipleImages(
      List<File> images) async {
    List<ProcessedImageData> processedImages = [];

    for (var image in images) {
      try {
        // Compress the image
        final compressedFile = await compressImage(image);

        // Convert to base64
        final base64String = await convertToBase64(compressedFile);

        // Generate filename
        final fileName = generateImageName('additional');

        // Add to processed list
        processedImages.add(ProcessedImageData(
          base64Data: base64String,
          fileName: fileName,
        ));

        // Clean up compressed file
        if (await compressedFile.exists()) {
          await compressedFile.delete();
        }
      } catch (e) {
        print('Error processing image: $e');
        // Continue processing other images even if one fails
        continue;
      }
    }

    return processedImages;
  }

  /// Clean up temporary files
  static Future<void> cleanupTempFiles() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final tempFiles = tempDir.listSync();

      for (var file in tempFiles) {
        if (file is File && file.path.contains('compressed')) {
          await file.delete();
          log("deleted");
        }
      }
    } catch (e) {
      print('Error cleaning up temp files: $e');
    }
  }
}
     // final imagePickerState =
                      //     context.read<ImagePickerBloc>().state;

                      // // Get all images from their respective states
                      // final meterImages = (imagePickerState['Meter Image']
                      //         as ImagePickerSuccessState)
                      //     .images;
                      // final flowrangeImages =
                      //     (imagePickerState['Flow Range Image']
                      //             as ImagePickerSuccessState)
                      //         .images;
                      // final filterChemicalImages =
                      //     (imagePickerState['Filter Chemical Image']
                      //             as ImagePickerSuccessState)
                      //         .images;
                      // final coinreadingImages =
                      //     (imagePickerState['Coin Reading Image']
                      //             as ImagePickerSuccessState)
                      //         .images;
                      // final plantFrontImages =
                      //     (imagePickerState['Plant Front Image']
                      //             as ImagePickerSuccessState)
                      //         .images;
                      // final plantBackImages =
                      //     (imagePickerState['Plant Back Image']
                      //             as ImagePickerSuccessState)
                      //         .images;
                      // final plantInsideImages =
                      //     (imagePickerState['Plant Inside Image']
                      //             as ImagePickerSuccessState)
                      //         .images;
                      // final additionalImages =
                      //     (imagePickerState['Additional Images']
                      //             as ImagePickerSuccessState)
                      //         .images;

                      // final processedMeterImage =
                      //     await ImageProcessor.processImage(meterImages.first);
                      // final processedFilterChemicalImage =
                      //     await ImageProcessor.processImage(
                      //         filterChemicalImages.first);
                      // final processedCoinReadingImage =
                      //     await ImageProcessor.processImage(
                      //         coinreadingImages.first);
                      // final processedFlowRangeImage =
                      //     await ImageProcessor.processImage(
                      //         flowrangeImages.first);
                      // final processedPlantFrontImage =
                      //     await ImageProcessor.processImage(
                      //         plantFrontImages.first);
                      // final processedPlantBackImage =
                      //     await ImageProcessor.processImage(
                      //         plantBackImages.first);
                      // final processedPlantInsideImage =
                      //     await ImageProcessor.processImage(
                      //         plantInsideImages.first);

                      // // Process additional images
                      // final processedAdditionalImages =
                      //     await ImageProcessor.processMultipleImages(
                      //         additionalImages);
                      // ////////////////
                      // final List<Picture> pictures = [
                      //   Picture(
                      //     imageName: ImageProcessor.generateImageName('Meter'),
                      //     pictureType: 'Meter',
                      //     image: processedMeterImage,
                      //   ),
                      //   Picture(
                      //     imageName:
                      //         ImageProcessor.generateImageName('FlowRange'),
                      //     pictureType: 'FlowRange',
                      //     image: processedFlowRangeImage,
                      //   ),
                      //   Picture(
                      //     imageName: ImageProcessor.generateImageName(
                      //         'FilterChemical'),
                      //     pictureType: 'FilterChemical',
                      //     image: processedFilterChemicalImage,
                      //   ),
                      //   Picture(
                      //     imageName:
                      //         ImageProcessor.generateImageName('CoinReading'),
                      //     pictureType: 'CoinReading',
                      //     image: processedCoinReadingImage,
                      //   ),
                      //   Picture(
                      //     imageName:
                      //         ImageProcessor.generateImageName('PlantFront'),
                      //     pictureType: 'PlantFront',
                      //     image: processedPlantFrontImage,
                      //   ),
                      //   Picture(
                      //     imageName:
                      //         ImageProcessor.generateImageName('PlantBack'),
                      //     pictureType: 'PlantBack',
                      //     image: processedPlantBackImage,
                      //   ),
                      //   Picture(
                      //     imageName:
                      //         ImageProcessor.generateImageName('PlantInside'),
                      //     pictureType: 'PlantInside',
                      //     image: processedPlantInsideImage,
                      //   ),
                      //   // Handle additional images with index
                      //   ...List.generate(
                      //       processedAdditionalImages.length,
                      //       (index) => Picture(
                      //             imageName: ImageProcessor.generateImageName(
                      //                 'Additional_$index'),
                      //             pictureType: 'Additional',
                      //             image: processedAdditionalImages[index],
                      //           )),
                      // ];
                      // if (!mounted) return;
                      //////////////////////////////////////////
                           // final imagePickerState =
                    //     context.read<ImagePickerBloc>().state;

                    // // Get all images from their respective states
                    // final meterImages = (imagePickerState['Meter Image']
                    //         as ImagePickerSuccessState)
                    //     .images;

                    // final plantFrontImages =
                    //     (imagePickerState['Plant Front Image']
                    //             as ImagePickerSuccessState)
                    //         .images;
                    // final plantBackImages =
                    //     (imagePickerState['Plant Back Image']
                    //             as ImagePickerSuccessState)
                    //         .images;
                    // final plantInsideImages =
                    //     (imagePickerState['Plant Inside Image']
                    //             as ImagePickerSuccessState)
                    //         .images;

                    // final processedMeterImage =
                    //     await ImageProcessor.processImage(meterImages.first);

                    // final processedPlantFrontImage =
                    //     await ImageProcessor.processImage(
                    //         plantFrontImages.first);
                    // final processedPlantBackImage =
                    //     await ImageProcessor.processImage(
                    //         plantBackImages.first);
                    // final processedPlantInsideImage =
                    //     await ImageProcessor.processImage(
                    //         plantInsideImages.first);

                    // ////////////////
                    // final List<Picture> pictures = [
                    //   Picture(
                    //     imageName: ImageProcessor.generateImageName('Meter'),
                    //     pictureType: 'Meter',
                    //     image: processedMeterImage,
                    //   ),
                    //   Picture(
                    //     imageName:
                    //         ImageProcessor.generateImageName('PlantFront'),
                    //     pictureType: 'PlantFront',
                    //     image: processedPlantFrontImage,
                    //   ),
                    //   Picture(
                    //     imageName:
                    //         ImageProcessor.generateImageName('PlantBack'),
                    //     pictureType: 'PlantBack',
                    //     image: processedPlantBackImage,
                    //   ),
                    //   Picture(
                    //     imageName:
                    //         ImageProcessor.generateImageName('PlantInside'),
                    //     pictureType: 'PlantInside',
                    //     image: processedPlantInsideImage,
                    //   ),
                    // ];
                    // if (!mounted) return;