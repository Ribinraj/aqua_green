import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.ontap,
    required this.text,
  });
  final void Function() ontap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: ResponsiveUtils.hp(6),
        width: ResponsiveUtils.screenWidth,
        color: Appcolors.kprimarycolor,
        child: Center(
          child: TextStyles.body(
            text: text,
            weight: FontWeight.bold,
            color: Appcolors.kwhiteColor,
          ),
        ),
      ),
    );
  }
}