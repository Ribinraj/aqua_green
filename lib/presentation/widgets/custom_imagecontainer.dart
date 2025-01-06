import 'dart:io';

import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/presentation/blocs/image_picker/image_picker_bloc.dart';
import 'package:aqua_green/presentation/widgets/custom_imagepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReusableImageContainer extends StatefulWidget {
  final String source;
  final double width;
  final double height;
  final String placeholder;
  final CustomImagePicker imagePicker;

  ReusableImageContainer({
    super.key,
    required this.source,
    this.width = 150,
    this.height = 150,
    this.placeholder = 'Take Photo',
    CustomImagePicker? imagePicker,
  }) : imagePicker = imagePicker ?? CustomImagePicker();

  @override
  State<ReusableImageContainer> createState() => _ReusableImageContainerState();
}

class _ReusableImageContainerState extends State<ReusableImageContainer> {
  void _onContainerTap(BuildContext context) {
    widget.imagePicker.showCameraDialog(
      context,
      onImagePicked: (File? pickedImage) {
        if (pickedImage != null) {
          context.read<ImagePickerBloc>().add(
                ImagePickedEvent(
                  image: pickedImage,
                  source: widget.source,
                ),
              );
        }
      },
    );
  }

  Widget _buildContainerContent(BuildContext context, ImagePickerState? state) {
    if (state is ImagePickerSuccessState && 
        state.hasImage && 
        state.imageFile != null) {
      // Show only picked image from camera
      return Image.file(
        state.imageFile!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error);
        },
      );
    }

    // Show placeholder if no image
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.camera_alt,
          size: 50,
          color: Appcolors.kprimarycolor,
        ),
        TextStyles.medium(
          text: widget.placeholder,
          color: Appcolors.kprimarycolor,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickerBloc, Map<String, ImagePickerState>>(
      builder: (context, state) {
        final imageState = state[widget.source];

        return GestureDetector(
          onTap: () => _onContainerTap(context),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                color: Appcolors.kwhiteColor,
                border: Border.all(color: Appcolors.kwhiteColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: _buildContainerContent(context, imageState),
            ),
          ),
        );
      },
    );
  }
}