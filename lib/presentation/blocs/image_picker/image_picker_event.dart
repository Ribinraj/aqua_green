part of 'image_picker_bloc.dart';

@immutable
sealed class ImagePickerEvent {}
// final class ImagePickedEvent extends ImagePickerEvent {
//   final File image;
//   final String source;

//   ImagePickedEvent({
//     required this.image,
//     required this.source,
//   });
// }
class ImagePickedEvent extends ImagePickerEvent {
  final File image;
  final String source;
  final bool isSingleImage;

  ImagePickedEvent({
    required this.image,
    required this.source,
    this.isSingleImage = false,
  });
}

class RemoveImageEvent extends ImagePickerEvent {
  final int index;
  final String source;

  RemoveImageEvent({
    required this.index,
    required this.source,
  });
}
