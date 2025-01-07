import 'dart:io';

import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';
import 'package:aqua_green/presentation/blocs/image_picker/image_picker_bloc.dart';
import 'package:aqua_green/presentation/widgets/custom_imagepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiImagePickerContainer extends StatelessWidget {
  final double containerWidth;
  final double containerHeight;
  final CustomImagePicker imagePicker;
  final String source;

  MultiImagePickerContainer({
    Key? key,
    this.containerWidth = 100,
    this.containerHeight = 100,
    this.source = 'default',
    CustomImagePicker? imagePicker,
  })  : imagePicker = imagePicker ?? CustomImagePicker(),
        super(key: key);

  void _onAddImageTap(BuildContext context) async {
    await imagePicker.showCameraDialog(
      context,
      onImagePicked: (File? pickedImage) {
        if (pickedImage != null) {
          context.read<ImagePickerBloc>().add(
                ImagePickedEvent(
                  image: pickedImage,
                  source: source,
                ),
              );
        }
      },
    );
  }

  Widget _buildImageContainer(File imageFile, int index, BuildContext context) {
    return Container(
      width: containerWidth,
      height: containerHeight,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Appcolors.kbackgroundcolor,
        border: Border.all(color: Appcolors.kprimarycolor, width: 0.5),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            imageFile,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
              onTap: () {
                context.read<ImagePickerBloc>().add(
                      RemoveImageEvent(
                        index: index,
                        source: source,
                      ),
                    );
              },
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: Appcolors.kprimarycolor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _onAddImageTap(context),
      child: Padding(
        padding: EdgeInsets.only(right: ResponsiveUtils.wp(3)),
        child: Container(
          width: containerWidth,
          height: containerHeight,
          decoration: BoxDecoration(
            color: Appcolors.kbackgroundcolor,
            border: Border.all(color: Appcolors.kprimarycolor, width: 0.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_alt,
                color: Appcolors.kprimarycolor,
              ),
              TextStyles.medium(
                text: 'Take Photo',
                color: Appcolors.kprimarycolor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickerBloc, Map<String, ImagePickerState>>(
      builder: (context, state) {
        final images =
            (state[source] as ImagePickerSuccessState?)?.images ?? [];

        return SizedBox(
          height: containerHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildAddButton(context);
              }
              return _buildImageContainer(
                  images[index - 1], index - 1, context);
            },
          ),
        );
      },
    );
  }
}
