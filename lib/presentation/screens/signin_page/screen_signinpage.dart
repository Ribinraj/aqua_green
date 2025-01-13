import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';
import 'package:aqua_green/presentation/blocs/otp_bloc/otp_bloc_bloc.dart';

import 'package:aqua_green/presentation/blocs/cubit/toggle_password_cubit.dart';
import 'package:aqua_green/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:aqua_green/presentation/screens/mainpage/screen_mainpage.dart';
import 'package:aqua_green/presentation/screens/screen_otp_page/screen_otppage.dart';

import 'package:aqua_green/presentation/screens/signin_page/widgets/toggle_passwordwidget.dart';
import 'package:aqua_green/presentation/widgets/custom_logintextfield.dart';
import 'package:aqua_green/presentation/widgets/custom_navigator.dart';
import 'package:aqua_green/presentation/widgets/custom_snackbar.dart';
import 'package:aqua_green/presentation/widgets/custom_submitbutton.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ScreenSigninPage extends StatefulWidget {
  const ScreenSigninPage({super.key});

  @override
  State<ScreenSigninPage> createState() => _ScreenSigninPageState();
}

class _ScreenSigninPageState extends State<ScreenSigninPage> {
  final TextEditingController mobilenumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final loginbloc = context.read<LoginBloc>();
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 234, 244, 249),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mobile number cannot be empty';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit mobile number';
                    }
                    return null;
                  },
                  controller: mobilenumberController,
                  labelText: 'Mobile Number',
                ),
                ResponsiveSizedBox.height20,
                TextStyles.body(text: 'Password', color: Appcolors.kblackColor),
                ResponsiveSizedBox.height10,
                CustomTextfield(
                  controller: passwordController,
                  labelText: 'Password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    return null;
                  },
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
                    BlocConsumer<OtpBlocBloc, OtpBlocState>(
                      listener: (context, state) {
                        if (state is OtpLoadingState) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              // ignore: deprecated_member_use
                              builder: (context) => WillPopScope(
                                  child: const Scaffold(
                                    body: Center(
                                      child: SpinKitWaveSpinner(
                                          color: Appcolors.kprimarycolor),
                                    ),
                                  ),
                                  onWillPop: () async => false));
                        } else {
                          CustomNavigation.pop(context);
                          if (state is OtpSuccessState) {
                            CustomNavigation.replace(
                                context,
                                ScreenOtppage(
                                  userid: state.userId,
                                  mobilenumber: mobilenumberController.text,
                                ));
                          } else if (state is OtpErrorState) {
                            CustomSnackBar.show(
                                context: context,
                                title: 'Error!',
                                message: state.message,
                                contentType: ContentType.failure);
                          }
                        }
                      },
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            if (mobilenumberController.text.length == 10 &&
                                mobilenumberController.text.isNotEmpty) {
                                   context.read<OtpBlocBloc>().add(SendOtpClickEvent(
                                mobilenumber: mobilenumberController.text));
                         
                            }else{
                                   CustomSnackBar.show(
                                  context: context,
                                  title: 'Error!',
                                  message: 'Enter validmobile number',
                                  contentType: ContentType.failure);
                            }
                           
                          },
                          child: TextStyles.medium(
                              text: 'Forgot Password?',
                              weight: FontWeight.bold,
                              color: Appcolors.kprimarycolor),
                        );
                      },
                    ),
                  ],
                ),
                ResponsiveSizedBox.height20,
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccessState) {
                      CustomNavigation.replace(context, ScreenMainPage());
                    } else if (state is LoginErrorState) {
                      CustomSnackBar.show(
                          context: context,
                          title: 'Error!',
                          message: state.message,
                          contentType: ContentType.failure);
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoadingState) {
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
                            loginbloc.add(LoginButtonClickingEvent(
                                mobielnumber: mobilenumberController.text,
                                password: passwordController.text));
                          } else {
                            CustomSnackBar.show(
                                context: context,
                                title: 'Error!!',
                                message: 'Fill all fields',
                                contentType: ContentType.failure);
                          }
                          //CustomNavigation.replace(context, ScreenMainPage());
                        },
                        text: 'Login');
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
