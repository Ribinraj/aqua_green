part of 'image_picker_bloc.dart';

@immutable
sealed class ImagePickerEvent {}
final class ImagePickedEvent extends ImagePickerEvent {
  final File image;
  final String source;

  ImagePickedEvent({
    required this.image,
    required this.source,
  });
}