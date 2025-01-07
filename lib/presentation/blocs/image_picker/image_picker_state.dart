part of 'image_picker_bloc.dart';

@immutable
sealed class ImagePickerState {}

final class ImagePickerInitial extends ImagePickerState {}
// final class ImagePickerSuccessState extends ImagePickerState {
//   final File? imageFile;
//   final bool hasImage;

//   ImagePickerSuccessState({
//      this.imageFile,
//     this.hasImage=false,
//   });
// }

class ImagePickerSuccessState extends ImagePickerState {
  final List<File> images;
  final bool isSingleImage;  // Flag to identify single-image sources

  ImagePickerSuccessState({
    required this.images,
    this.isSingleImage = false,
  });

  // Helper getter for single image cases
  File? get singleImage => images.isNotEmpty ? images.first : null;
}