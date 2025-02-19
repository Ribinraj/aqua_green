import 'package:aqua_green/core/colors.dart';
import 'package:flutter/material.dart';

class CustomTextfieldaddmeasure extends StatefulWidget {
  const CustomTextfieldaddmeasure(
      {super.key,
      required this.controller,
      this.textInputType,
      this.validator,
      this.suffixIcon,
      required this.hinttext,
      this.readonly,
      // this.maxlines
      });

  final TextEditingController controller;

  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  // final int? maxlines;
  final String hinttext;
  final bool? readonly;

  @override
  State<CustomTextfieldaddmeasure> createState() => _CustomTextfieldaddmeasureState();
}

class _CustomTextfieldaddmeasureState extends State<CustomTextfieldaddmeasure> {
   @override
  void initState() {
    super.initState();
    // Add listener to controller
    widget.controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Appcolors.kprimarycolor,
      validator: widget.validator,
      controller: widget.controller,
      // maxLines: maxlines,
      keyboardType: widget.textInputType,
      readOnly: widget.readonly ?? false,
      style: const TextStyle(
        fontSize: 13,
      ),
      decoration: InputDecoration(
          fillColor: Appcolors.kwhiteColor,
          filled: true,
          // border: InputBorder.none,
          isDense: true,
          errorMaxLines: 3,
          suffixIcon: widget.suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          hintText: widget.hinttext,
          hintStyle:
              const TextStyle(fontSize: 11, color: Appcolors.kdarkbluecolor),
          enabledBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: Appcolors.kprimarycolor, width: .5)),
          focusedBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: Appcolors.kprimarycolor, width: .5)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Appcolors.kredColor, width: .5)),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Appcolors.kredColor, width: .5))),
    );
  }
    @override
  void dispose() {
    // Remove listener when widget is disposed
    widget.controller.removeListener(() {});
    super.dispose();
  }
}
