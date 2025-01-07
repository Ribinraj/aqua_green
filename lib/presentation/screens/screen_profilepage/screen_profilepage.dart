import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';
import 'package:aqua_green/presentation/screens/screen_reset_password/screen_reset_passwordpage.dart';
import 'package:flutter/material.dart';

class ScreenProfilepage extends StatefulWidget {
  const ScreenProfilepage({super.key});

  @override
  State<ScreenProfilepage> createState() => _ScreenProfilepageState();
}

class _ScreenProfilepageState extends State<ScreenProfilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
      children: [
        SizedBox(
          height: ResponsiveUtils.hp(10),
        ),
        Container(
          height: ResponsiveUtils.hp(20),
          decoration: const BoxDecoration(
              color: Appcolors.kwhiteColor, shape: BoxShape.circle),
          child: Center(
            child: Container(
              height: ResponsiveUtils.hp(15),
              width: ResponsiveUtils.wp(27),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/Aqua Green Logos-updated.png',
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        ResponsiveSizedBox.height50,
        Container(
          padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
          color: Appcolors.kwhiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextStyles.medium(
                  text: 'User Name',
                  weight: FontWeight.bold,
                  color: Appcolors.kprimarycolor),
              ResponsiveSizedBox.height5,
              nameContainer(text: 'muhammed akbar'),
              ResponsiveSizedBox.height20,
              TextStyles.medium(
                  text: 'Mobile Number',
                  weight: FontWeight.bold,
                  color: Appcolors.kprimarycolor),
              ResponsiveSizedBox.height5,
              nameContainer(text: '9946802969'),
              ResponsiveSizedBox.height10,
              Divider(
                thickness: .5,
                color: Appcolors.kgreenColor,
              ),
              ResponsiveSizedBox.height10,
              Row(
                children: [
                  const Spacer(),
                  TextStyles.medium(
                      text: 'Logout',
                      weight: FontWeight.bold,
                      color: Appcolors.kredColor),
                  ResponsiveSizedBox.width10,
                ],
              )
            ],
          ),
        ),
        ResponsiveSizedBox.height30,
        SubmitButton(ontap: () {}, text: 'Edit')
      ],
    ));
  }

  Container nameContainer({required String text}) {
    return Container(
      width: ResponsiveUtils.screenWidth,
      padding: EdgeInsets.all(ResponsiveUtils.wp(3.5)),
      decoration: BoxDecoration(
        border: Border.all(
          color: Appcolors.kprimarycolor,
          width: 0.5,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
