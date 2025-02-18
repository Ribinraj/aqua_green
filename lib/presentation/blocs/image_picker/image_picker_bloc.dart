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
    on<ClearAllImagesEvent>(_onClearAllImages);
        
  }
   FutureOr<void> _onAddImage(ImagePickedEvent event, Emitter<Map<String, ImagePickerState>> emit) {
    final currentState = Map<String, ImagePickerState>.from(state);
    final currentImageState = currentState[event.source] as ImagePickerSuccessState?;
    
    final currentImages = currentImageState?.images ?? [];
    final currentProcessedImages = currentImageState?.processedImages ?? [];

    if (event.isSingleImage) {
      // For single-image sources, replace existing
      currentState[event.source] = ImagePickerSuccessState(
        images: [event.image],
        processedImages: [event.processdData],
        isSingleImage: true,
      );
    } else {
      // For multi-image sources, add to list
      currentState[event.source] = ImagePickerSuccessState(
        images: [...currentImages, event.image],
        processedImages: [...currentProcessedImages, event.processdData],
        isSingleImage: false,
      );
    }

    emit(currentState);
  }

  // FutureOr<void> _onAddImage(ImagePickedEvent event, Emitter<Map<String, ImagePickerState>> emit) {
  //   final currentState = Map<String, ImagePickerState>.from(state);
  //   final currentImages = (currentState[event.source] as ImagePickerSuccessState?)?.images ?? [];
    
  //   if (event.isSingleImage) {
  //     // For single-image sources, replace the existing image
  //     currentState[event.source] = ImagePickerSuccessState(
  //       images: [event.image],
  //       isSingleImage: true,
  //     );
  //   } else {
  //     // For multi-image sources, add to the list
  //     currentState[event.source] = ImagePickerSuccessState(
  //       images: [...currentImages, event.image],
  //       isSingleImage: false,
  //     );
  //   }
    
  //   emit(currentState);
  // }
FutureOr<void> _onRemoveImage(RemoveImageEvent event, Emitter<Map<String, ImagePickerState>> emit) {
  final currentState = Map<String, ImagePickerState>.from(state);
  final imageState = currentState[event.source] as ImagePickerSuccessState?;
  
  if (imageState != null) {
    final currentImages = imageState.images;
    final currentProcessedImages = imageState.processedImages;
    
    if (event.index >= 0 && event.index < currentImages.length) {
      // Create new lists with the item removed at the specified index
      final newImages = List<File>.from(currentImages)..removeAt(event.index);
      final newProcessedImages = List<ProcessedImageData>.from(currentProcessedImages)..removeAt(event.index);
      
      // Update state with both lists updated
      currentState[event.source] = ImagePickerSuccessState(
        images: newImages,
        processedImages: newProcessedImages,
        isSingleImage: imageState.isSingleImage,
      );
      
      emit(currentState);
    }
  }
}
  // FutureOr<void> _onRemoveImage(RemoveImageEvent event, Emitter<Map<String, ImagePickerState>> emit) {
  //   final currentState = Map<String, ImagePickerState>.from(state);
  //   final imageState = currentState[event.source] as ImagePickerSuccessState?;
    
  //   if (imageState != null) {
  //     final currentImages = imageState.images;
  //     if (event.index >= 0 && event.index < currentImages.length) {
  //       final newImages = List<File>.from(currentImages)..removeAt(event.index);
        
  //       currentState[event.source] = ImagePickerSuccessState(
  //         images: newImages,
  //         processedImages: ,
  //         isSingleImage: imageState.isSingleImage,
  //       );
  //       emit(currentState);
  //     }
  //   }
  // }
    FutureOr<void> _onClearAllImages(ClearAllImagesEvent event, Emitter<Map<String, ImagePickerState>> emit) {
    // Create a new map with empty states for all image types
    final clearedState = {
      'Meter Image': ImagePickerSuccessState(images: const [], processedImages:const [],isSingleImage: true),
      'Flow Range Image': ImagePickerSuccessState(images: const [], processedImages:const [], isSingleImage: true),
      'Filter Chemical Image': ImagePickerSuccessState(images: const [], processedImages: const[], isSingleImage: true),
      'Coin Reading Image': ImagePickerSuccessState(images: const [], processedImages:const [], isSingleImage: true),
      'Plant Front Image': ImagePickerSuccessState(images: const [], processedImages: const[], isSingleImage: true),
      'Plant Back Image': ImagePickerSuccessState(images: const [], processedImages:const [], isSingleImage: true),
      'Plant Inside Image': ImagePickerSuccessState(images: const [], processedImages: const[], isSingleImage: true),
      'Additional Images': ImagePickerSuccessState(images: const [], processedImages: const[], isSingleImage: false),
    };
    
    emit(clearedState);
  }
}