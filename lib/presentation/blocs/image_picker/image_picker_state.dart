part of 'image_picker_bloc.dart';

@immutable
sealed class ImagePickerState {}

// final class ImagePickerInitial extends ImagePickerState {}
// // final class ImagePickerSuccessState extends ImagePickerState {
// //   final File? imageFile;
// //   final bool hasImage;

// //   ImagePickerSuccessState({
// //      this.imageFile,
// //     this.hasImage=false,
// //   });
// // }

// class ImagePickerSuccessState extends ImagePickerState {
//   final List<File> images;
//   final bool isSingleImage;  // Flag to identify single-image sources

//   ImagePickerSuccessState({
//     required this.images,
//     this.isSingleImage = false,
//   });

//   // Helper getter for single image cases
//   File? get singleImage => images.isNotEmpty ? images.first : null;
// }
final class ImagePickerInitial extends ImagePickerState {}

class ImagePickerSuccessState extends ImagePickerState {
  final List<File> images;
  final List<ProcessedImageData> processedImages; // Add this to store processed data
  final bool isSingleImage;

  ImagePickerSuccessState({
    required this.images,
    required this.processedImages,
    this.isSingleImage = false,
  });

  File? get singleImage => images.isNotEmpty ? images.first : null;
}

////////////
class ProcessedImageData {
  final String base64Data;
  final String fileName;

  ProcessedImageData({
    required this.base64Data,
    required this.fileName,
  });
}