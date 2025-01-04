import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';

import 'package:aqua_green/presentation/blocs/cubit/toggle_password_cubit.dart';
import 'package:aqua_green/presentation/screens/mainpage/screen_mainpage.dart';
import 'package:aqua_green/presentation/screens/screen_otp_page/screen_otppage.dart';
import 'package:aqua_green/presentation/screens/screen_reset_password/screen_reset_passwordpage.dart';
import 'package:aqua_green/presentation/screens/signin_page/widgets/toggle_passwordwidget.dart';
import 'package:aqua_green/presentation/widgets/custom_logintextfield.dart';
import 'package:aqua_green/presentation/widgets/custom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenSigninPage extends StatefulWidget {
  const ScreenSigninPage({super.key});

  @override
  State<ScreenSigninPage> createState() => _ScreenSigninPageState();
}

class _ScreenSigninPageState extends State<ScreenSigninPage> {
  final TextEditingController mobilenumberController = TextEditingController();
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
                height: ResponsiveUtils.hp(32),
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
              const Text(
                'Login',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Appcolors.kprimarycolor),
              ),
              ResponsiveSizedBox.height30,
              TextStyles.body(
                  text: 'Mobile Number', color: Appcolors.kblackColor),
              ResponsiveSizedBox.height10,
              CustomTextfield(
                controller: mobilenumberController,
                labelText: 'Mobile Number',
              ),
              ResponsiveSizedBox.height20,
              TextStyles.body(text: 'Password', color: Appcolors.kblackColor),
              ResponsiveSizedBox.height10,
              CustomTextfield(
                controller: passwordController,
                labelText: 'Password',
                obscureText: !context
                    .watch<TogglePasswordCubit>()
                    .state
                    .isPasswordVisible,
                suffixIcon: togglePassword(),
              ),
              ResponsiveSizedBox.height5,
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      CustomNavigation.replace(context, ScreenOtppage());
                    },
                    child: TextStyles.medium(
                        text: 'Forgot Password?',
                        weight: FontWeight.bold,
                        color: Appcolors.kprimarycolor),
                  ),
                ],
              ),
              ResponsiveSizedBox.height20,
              GestureDetector(
                onTap: () {},
                child: SubmitButton(
                    ontap: () {
                      CustomNavigation.replace(context, ScreenMainPage());
                    },
                    text: 'Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
