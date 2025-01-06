part of 'image_picker_bloc.dart';

@immutable
sealed class ImagePickerState {}

final class ImagePickerInitial extends ImagePickerState {}
final class ImagePickerSuccessState extends ImagePickerState {
  final File? imageFile;
  final bool hasImage;

  ImagePickerSuccessState({
     this.imageFile,
    this.hasImage=false,
  });
}