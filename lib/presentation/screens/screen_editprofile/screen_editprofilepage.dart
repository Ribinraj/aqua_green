import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';
import 'package:aqua_green/presentation/blocs/bloc/update_profile_bloc.dart';
import 'package:aqua_green/presentation/blocs/fetch_profile/fetch_profile_bloc.dart';
import 'package:aqua_green/presentation/widgets/custom_logintextfield.dart';
import 'package:aqua_green/presentation/widgets/custom_navigator.dart';
import 'package:aqua_green/presentation/widgets/custom_snackbar.dart';
import 'package:aqua_green/presentation/widgets/custom_submitbutton.dart';
import 'package:aqua_green/presentation/widgets/customrout_mainpage.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ScreenEditProfilepage extends StatefulWidget {
  final String fullname;
  const ScreenEditProfilepage({super.key, required this.fullname});

  @override
  State<ScreenEditProfilepage> createState() => _ScreenEditProfilepageState();
}

class _ScreenEditProfilepageState extends State<ScreenEditProfilepage> {
  late TextEditingController fullnamecontroller;
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isEditingPassword = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullnamecontroller = TextEditingController(text: widget.fullname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Appcolors.kbackgroundcolor,
          leading: IconButton(
              onPressed: () {
                CustomNavigation.pop(context);
              },
              icon: Icon(
                Icons.chevron_left,
                size: ResponsiveUtils.wp(8),
              )),
          title: TextStyles.body(
              weight: FontWeight.bold,
              text: "Edit Profile",
              color: Appcolors.kprimarycolor),
          centerTitle: true,
        ),
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
                      text: 'Full Name',
                      weight: FontWeight.bold,
                      color: Appcolors.kprimarycolor),
                  ResponsiveSizedBox.height5,
                  CustomTextfield(
                      controller: fullnamecontroller, labelText: 'Full Name'),
                  ResponsiveSizedBox.height20,
                  // Password Toggle Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextStyles.medium(
                          text: 'Change Password',
                          weight: FontWeight.bold,
                          color: Appcolors.kprimarycolor),
                      Switch(
                        value: isEditingPassword,
                        onChanged: (value) {
                          setState(() {
                            isEditingPassword = value;
                            if (!value) {
                              // Clear password controllers when toggle is turned off
                              newPasswordController.clear();
                              confirmPasswordController.clear();
                            }
                          });
                        },
                        inactiveTrackColor: Appcolors.kwhiteColor,
                        inactiveThumbColor: Appcolors.kprimarycolor,
                        activeColor: Appcolors.kprimarycolor,
                      ),
                    ],
                  ),
                  // Password Fields (visible only when toggle is on)
                  if (isEditingPassword) ...[
                    ResponsiveSizedBox.height20,
                    TextStyles.medium(
                        text: 'New Password',
                        weight: FontWeight.bold,
                        color: Appcolors.kprimarycolor),
                    ResponsiveSizedBox.height5,
                    CustomTextfield(
                      controller: newPasswordController,
                      labelText: 'New Password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password cannot be empty';
                        }
                        return null;
                      },
                    ),
                    ResponsiveSizedBox.height20,
                    TextStyles.medium(
                        text: 'Confirm Password',
                        weight: FontWeight.bold,
                        color: Appcolors.kprimarycolor),
                    ResponsiveSizedBox.height5,
                    CustomTextfield(
                      controller: confirmPasswordController,
                      labelText: 'Confirm Password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Confirm Password cannot be empty";
                        }
                        if (value != newPasswordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                  ],
                ],
              ),
            ),
            ResponsiveSizedBox.height30,
            BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
              listener: (context, state) {
                if (state is UpdateProfileSuccessState) {
                  CustomSnackBar.show(
                      context: context,
                      title: 'Success',
                      message: 'Profile updated Successfully',
                      contentType: ContentType.success);

                  navigateToMainPage(context, 4);
                }
                if (state is UpdateProfileErrorState) {
                  CustomSnackBar.show(
                      context: context,
                      title: 'Error',
                      message: state.message,
                      contentType: ContentType.failure);
                  CustomNavigation.pop(context);
                }
              },
              builder: (context, state) {
                if (state is UpdatProfileLoadingState) {
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
                // return SubmitButton(
                //     ontap: () {
                //       context.read<UpdateProfileBloc>().add(
                //           UpdateProfileButtonclickEvent(
                //               fullname: fullnamecontroller.text,
                //               password: newPasswordController.text));
                //     },
                //     text: 'Update');
                return SubmitButton(
                    ontap: () {
                      // Validate fullname is not empty
                      if (fullnamecontroller.text.trim().isEmpty) {
                        CustomSnackBar.show(
                            context: context,
                            title: 'Error',
                            message: 'Full name is required',
                            contentType: ContentType.failure);
                        return;
                      }

                      // Check if password update is enabled
                      if (isEditingPassword) {
                        // Validate new password is not empty
                        if (newPasswordController.text.isEmpty) {
                          CustomSnackBar.show(
                              context: context,
                              title: 'Error',
                              message: 'New password is required',
                              contentType: ContentType.failure);
                          return;
                        }

                        // Validate confirm password is not empty
                        if (confirmPasswordController.text.isEmpty) {
                          CustomSnackBar.show(
                              context: context,
                              title: 'Error',
                              message: 'Confirm password is required',
                              contentType: ContentType.failure);
                          return;
                        }

                        // Validate passwords match
                        if (newPasswordController.text !=
                            confirmPasswordController.text) {
                          CustomSnackBar.show(
                              context: context,
                              title: 'Error',
                              message: 'Passwords do not match',
                              contentType: ContentType.failure);
                          return;
                        }

                        // If all validations pass, update profile with new password
                        context.read<UpdateProfileBloc>().add(
                            UpdateProfileButtonclickEvent(
                                fullname: fullnamecontroller.text,
                                password: confirmPasswordController.text));
                      } else {
                        // If password update is not enabled, just update the fullname
                        context.read<UpdateProfileBloc>().add(
                            UpdateProfileButtonclickEvent(
                                fullname: fullnamecontroller.text,
                                password: newPasswordController.text));
                      }
                    },
                    text: 'Update');
              },
            )
          ],
        ));
  }
}
