import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

// class ImagePickerBloc extends Bloc<ImagePickerEvent, Map<String, ImagePickerState>> {
//   ImagePickerBloc() : super({}) {
//     on<ImagePickedEvent>(_onImagePicked);
//   }

//   FutureOr<void> _onImagePicked(ImagePickedEvent event, Emitter<Map<String, ImagePickerState>> emit) {
//     final currentState = Map<String, ImagePickerState>.from(state);
//     currentState[event.source] = ImagePickerSuccessState(
//       imageFile: event.image,
//       hasImage: true,
//     );
//     emit(currentState);
//   }
// }
class ImagePickerBloc extends Bloc<ImagePickerEvent, Map<String, ImagePickerState>> {
  ImagePickerBloc() : super({}) {
    on<ImagePickedEvent>(_onAddImage);
    on<RemoveImageEvent>(_onRemoveImage);
        
  }

  FutureOr<void> _onAddImage(ImagePickedEvent event, Emitter<Map<String, ImagePickerState>> emit) {
    final currentState = Map<String, ImagePickerState>.from(state);
    final currentImages = (currentState[event.source] as ImagePickerSuccessState?)?.images ?? [];
    
    if (event.isSingleImage) {
      // For single-image sources, replace the existing image
      currentState[event.source] = ImagePickerSuccessState(
        images: [event.image],
        isSingleImage: true,
      );
    } else {
      // For multi-image sources, add to the list
      currentState[event.source] = ImagePickerSuccessState(
        images: [...currentImages, event.image],
        isSingleImage: false,
      );
    }
    
    emit(currentState);
  }

  FutureOr<void> _onRemoveImage(RemoveImageEvent event, Emitter<Map<String, ImagePickerState>> emit) {
    final currentState = Map<String, ImagePickerState>.from(state);
    final imageState = currentState[event.source] as ImagePickerSuccessState?;
    
    if (imageState != null) {
      final currentImages = imageState.images;
      if (event.index >= 0 && event.index < currentImages.length) {
        final newImages = List<File>.from(currentImages)..removeAt(event.index);
        currentState[event.source] = ImagePickerSuccessState(
          images: newImages,
          isSingleImage: imageState.isSingleImage,
        );
        emit(currentState);
      }
    }
  }
  
}