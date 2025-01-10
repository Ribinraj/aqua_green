import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';


import 'package:aqua_green/presentation/widgets/custom_logintextfield.dart';
import 'package:aqua_green/presentation/widgets/custom_navigator.dart';
import 'package:aqua_green/presentation/widgets/custom_submitbutton.dart';
import 'package:flutter/material.dart';

class ScreenEditProfilepage extends StatefulWidget {
  const ScreenEditProfilepage({super.key});

  @override
  State<ScreenEditProfilepage> createState() => _ScreenEditProfilepageState();
}

class _ScreenEditProfilepageState extends State<ScreenEditProfilepage> {
  final TextEditingController mobilenumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                  text: 'Mobile Number',
                  weight: FontWeight.bold,
                  color: Appcolors.kprimarycolor),
              ResponsiveSizedBox.height5,
              CustomTextfield(
                  controller: passwordController, labelText: 'Mobile number'),
              ResponsiveSizedBox.height20,
              TextStyles.medium(
                  text: 'Password',
                  weight: FontWeight.bold,
                  color: Appcolors.kprimarycolor),
              ResponsiveSizedBox.height5,
              CustomTextfield(
                  controller: passwordController, labelText: 'Password'),
            ],
          ),
        ),
        ResponsiveSizedBox.height30,
        SubmitButton(
            ontap: () {
              CustomNavigation.pop(context);
            },
            text: 'Update')
      ],
    ));
  }
}
