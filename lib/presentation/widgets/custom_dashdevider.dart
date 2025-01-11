import 'package:flutter/material.dart';

class DashedDivider extends StatelessWidget {
  final double dashWidth;
  final double dashHeight;
  final double gapWidth;
  final Color color;

  const DashedDivider({
    Key? key,
    this.dashWidth = 5.0,
    this.dashHeight = 1.0,
    this.gapWidth = 3.0,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double dashCount = (constraints.maxWidth / (dashWidth + gapWidth)).floorToDouble();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount.toInt(), (index) {
            return Container(
              width: dashWidth,
              height: dashHeight,
              color: color,
            );
          }),
        );
      },
    );
  }
}
