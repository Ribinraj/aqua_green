import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';
import 'package:aqua_green/presentation/widgets/custom_largetextwidget.dart';
import 'package:aqua_green/presentation/widgets/custom_navigator.dart';
import 'package:aqua_green/presentation/widgets/custom_textwidget.dart';
import 'package:flutter/material.dart';

class ScreenReportDetailpage extends StatefulWidget {
  const ScreenReportDetailpage({super.key});

  @override
  State<ScreenReportDetailpage> createState() => _ScreenReportDetailpageState();
}

class _ScreenReportDetailpageState extends State<ScreenReportDetailpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              CustomNavigation.pop(context);
            },
            icon: Icon(
              Icons.chevron_left,
              size: ResponsiveUtils.wp(8),
            )),
        title: TextStyles.body(
          text: 'Report Details',
          color: Appcolors.kprimarycolor,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
        children: [
          Container(
            padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
            color: Appcolors.kwhiteColor,
            child: Column(
              children: [
                CustomLargeTextWidget(
                    context: context, heading: 'Route', details: '1'),
                ResponsiveSizedBox.height5,
                CustomLargeTextWidget(
                    context: context, heading: 'Area', details: 'Jss layout'),
                ResponsiveSizedBox.height5,
                CustomTextWidget(
                    context: context, heading: 'Date', details: '08/09/2024')
              ],
            ),
          )
        ],
      ),
    );
  }
}
