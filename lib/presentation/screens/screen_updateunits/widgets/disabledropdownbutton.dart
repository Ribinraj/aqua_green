import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DisabledDropdown extends StatelessWidget {
  final String hintText;

  const DisabledDropdown({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.wp(.2)),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey[400]!, width: 0.5),
      ),
      child: DropdownButtonFormField2<String>(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          border: InputBorder.none,
        ),
        hint: TextStyles.caption(text: hintText, color: Colors.grey[600]!),
        items: const [],
        onChanged: null,
        buttonStyleData: const ButtonStyleData(),
      ),
    );
  }
}
