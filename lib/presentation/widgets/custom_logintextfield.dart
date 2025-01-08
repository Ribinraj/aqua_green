import 'package:aqua_green/core/colors.dart';

import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.labelText,
    this.textInputType,
    this.validator,
    this.suffixIcon,
    this.obscureText,
  });

  final TextEditingController controller;
  final String labelText;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Appcolors.kprimarycolor,
      validator: validator,
      controller: controller,
      obscureText: obscureText ?? false,
      keyboardType: textInputType,
      style: const TextStyle(
        fontSize: 15,
      ),
      decoration: InputDecoration(
          fillColor: Appcolors.kwhiteColor,
          filled: true,
          // border: InputBorder.none,
          isDense: true,
          errorMaxLines: 3,
          suffixIcon: suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          hintText: labelText,
          hintStyle: const TextStyle(color: Appcolors.kgreyColor, fontSize: 13),
          enabledBorder: const OutlineInputBorder(
              //borderRadius: BorderRadiusStyles.kradius5(),
              borderSide:
                  BorderSide(color: Appcolors.kprimarycolor, width: .5)),
          focusedBorder: const OutlineInputBorder(
              //borderRadius: BorderRadiusStyles.kradius30(),
              borderSide:
                  BorderSide(color: Appcolors.kprimarycolor, width: .5)),
          errorBorder: const OutlineInputBorder(
              //borderRadius: BorderRadiusStyles.kradius30(),
              borderSide: BorderSide(color: Appcolors.kredColor, width: .5)),
          focusedErrorBorder: const OutlineInputBorder(
              // borderRadius: BorderRadiusStyles.kradius30(),
              borderSide: BorderSide(color: Appcolors.kredColor, width: .5))),
    );
  }
}
