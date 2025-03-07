import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';

import 'package:flutter/material.dart';

class CustomLargeTextWidget extends StatelessWidget {
  const CustomLargeTextWidget({
    super.key,
    required this.context,
    required this.heading,
    required this.details,
  });

  final BuildContext context;
  final String heading;
  final String details;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 5, left: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: ResponsiveUtils.wp(45),
              child: TextStyles.caption(
                  text: heading,
                  color: Appcolors.kblackColor,
                  weight: FontWeight.bold)),
          const Text(
            ':',
            style: TextStyle(
                color: Appcolors.kblackColor,
                fontSize: 10,
                fontWeight: FontWeight.bold),
          ),
          ResponsiveSizedBox.width20,
          Expanded(
            child: TextStyles.caption(
                text: details,
                color: Appcolors.kblackColor,
                weight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
