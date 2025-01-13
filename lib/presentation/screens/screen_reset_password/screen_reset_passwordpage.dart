import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';
import 'package:aqua_green/presentation/blocs/update_password/update_password_bloc.dart';
import 'package:aqua_green/presentation/screens/signin_page/screen_signinpage.dart';

import 'package:aqua_green/presentation/widgets/custom_logintextfield.dart';
import 'package:aqua_green/presentation/widgets/custom_navigator.dart';
import 'package:aqua_green/presentation/widgets/custom_snackbar.dart';
import 'package:aqua_green/presentation/widgets/custom_submitbutton.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ScreenResetPasswordpage extends StatefulWidget {
  final String userId;
  const ScreenResetPasswordpage({super.key, required this.userId});

  @override
  State<ScreenResetPasswordpage> createState() => _ScreenSigninPageState();
}

class _ScreenSigninPageState extends State<ScreenResetPasswordpage> {
  final TextEditingController confirompasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 234, 244, 249),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ResponsiveUtils.wp(6)),
          child: Form(
            key: formKey,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    return null;
                  },
                ),
                ResponsiveSizedBox.height20,
                TextStyles.body(
                    text: 'Confirm Password', color: Appcolors.kblackColor),
                ResponsiveSizedBox.height10,
                CustomTextfield(
                  validator: (value) {
    if (value == null || value.isEmpty) {
      return "Confirm Password cannot be empty";
    }
    if (value != passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  },
                  controller: confirompasswordController,
                  labelText: 'Confirm Password',
                ),
                ResponsiveSizedBox.height30,
                BlocConsumer<UpdatePasswordBloc, UpdatePasswordState>(
                  listener: (context, state) {
                    if (state is UpdatePasswordSuccessState) {
                      CustomSnackBar.show(
                          context: context,
                          title: 'Success!',
                          message: 'User Password updated successfully',
                          contentType: ContentType.success);
                      CustomNavigation.replace(
                          context, const ScreenSigninPage());
                    } else if (state is UpdatepasswordErrorState) {
                      CustomSnackBar.show(
                          context: context,
                          title: 'Error!',
                          message: state.message,
                          contentType: ContentType.failure);
                    }
                  },
                  builder: (context, state) {
                    if (state is UpdatePasswordLoadingState) {
                     return Container(
                        height: ResponsiveUtils.hp(6),
                        width: ResponsiveUtils.screenWidth,
                        color: Appcolors.kprimarycolor,
                        child: Center(
                            child: SpinKitWave(
                          color: Appcolors.kwhiteColor,
                          size: ResponsiveUtils.wp(6),
                        )),
                      );
                    }
                    return SubmitButton(
                        ontap: () {
                           if (formKey.currentState!.validate()) {
                          context.read<UpdatePasswordBloc>().add(
                              UpdatePasswordButtonClickEvent(
                                  userId: widget.userId,
                                  password: confirompasswordController.text));
                          } else {
                            CustomSnackBar.show(
                                context: context,
                                title: 'Error!!',
                                message: 'Fill all fields',
                                contentType: ContentType.failure);
                          }
                          
                        
                        },
                        text: 'Submit');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class SubmitButton extends StatelessWidget {
//   const SubmitButton({
//     super.key,
//     required this.ontap,
//     required this.text,
//   });
//   final void Function() ontap;
//   final String text;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: ontap,
//       child: Container(
//         height: ResponsiveUtils.hp(6),
//         width: ResponsiveUtils.screenWidth,
//         color: Appcolors.kprimarycolor,
//         child: Center(
//           child: TextStyles.body(
//             text: text,
//             weight: FontWeight.bold,
//             color: Appcolors.kwhiteColor,
//           ),
//         ),
//       ),
//     );
//   }
// }
