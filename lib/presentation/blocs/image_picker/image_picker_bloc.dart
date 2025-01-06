import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, Map<String, ImagePickerState>> {
  ImagePickerBloc() : super({}) {
    on<ImagePickedEvent>(_onImagePicked);
  }

  FutureOr<void> _onImagePicked(ImagePickedEvent event, Emitter<Map<String, ImagePickerState>> emit) {
    final currentState = Map<String, ImagePickerState>.from(state);
    currentState[event.source] = ImagePickerSuccessState(
      imageFile: event.image,
      hasImage: true,
    );
    emit(currentState);
  }
}