import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';
import 'package:aqua_green/presentation/screens/signin_page/screen_signinpage.dart';

import 'package:aqua_green/presentation/widgets/custom_logintextfield.dart';
import 'package:aqua_green/presentation/widgets/custom_navigator.dart';

import 'package:flutter/material.dart';

class ScreenResetPasswordpage extends StatefulWidget {
  const ScreenResetPasswordpage({super.key});

  @override
  State<ScreenResetPasswordpage> createState() => _ScreenSigninPageState();
}

class _ScreenSigninPageState extends State<ScreenResetPasswordpage> {
  final TextEditingController confirompasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 234, 244, 249),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ResponsiveUtils.wp(6)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: ResponsiveUtils.hp(7),
              ),
              Container(
                height: ResponsiveUtils.hp(30),
                //width: ResponsiveUtils.hp(20),
                decoration: const BoxDecoration(
                    color: Appcolors.kwhiteColor, shape: BoxShape.circle
                    // borderRadius: BorderRadius.only(
                    //     bottomLeft: Radius.circular(30),
                    //     bottomRight: Radius.circular(30))
                    ),
                child: Center(
                  child: Container(
                    height: ResponsiveUtils.hp(15),
                    width: ResponsiveUtils.wp(40),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/Aqua Green Logos-updated.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              ResponsiveSizedBox.height20,
              const Text(
                'Reset Password',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Appcolors.kprimarycolor),
              ),
              ResponsiveSizedBox.height30,
              TextStyles.body(
                  text: 'New Passoword', color: Appcolors.kblackColor),
              ResponsiveSizedBox.height10,
              CustomTextfield(
                controller: passwordController,
                labelText: 'Enter new password',
              ),
              ResponsiveSizedBox.height20,
              TextStyles.body(
                  text: 'Confirm Password', color: Appcolors.kblackColor),
              ResponsiveSizedBox.height10,
              CustomTextfield(
                controller: passwordController,
                labelText: 'Confirm Password',
              ),
              ResponsiveSizedBox.height30,
              SubmitButton(
                  ontap: () {
                    CustomNavigation.replace(context, const ScreenSigninPage());
                  },
                  text: 'Submit')
            ],
          ),
        ),
      ),
    );
  }
}

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
