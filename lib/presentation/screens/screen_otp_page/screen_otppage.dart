import 'dart:async';

import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';
import 'package:aqua_green/presentation/blocs/otp_bloc/otp_bloc_bloc.dart';
import 'package:aqua_green/presentation/blocs/resend_otp/resend_otp_bloc.dart';
import 'package:aqua_green/presentation/blocs/verify_otpbloc/verify_otp_bloc.dart';
import 'package:aqua_green/presentation/screens/screen_reset_password/screen_reset_passwordpage.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:aqua_green/presentation/widgets/custom_navigator.dart';
import 'package:aqua_green/presentation/widgets/custom_snackbar.dart';
import 'package:aqua_green/presentation/widgets/custom_submitbutton.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ScreenOtppage extends StatefulWidget {
  final String userid;
  final String mobilenumber;
  const ScreenOtppage(
      {super.key, required this.userid, required this.mobilenumber});

  @override
  State<ScreenOtppage> createState() => _ScreenOtppageState();
}

class _ScreenOtppageState extends State<ScreenOtppage> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  Timer? _timer;
  int _secondsRemaining = 30;
  bool _isTimerActive = true;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    setState(() {
      _secondsRemaining = 30;
      _isTimerActive = true;
    });

    // Cancel existing timer if any
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _isTimerActive = false;
          timer.cancel(); // Use the timer parameter instead of _timer
        }
      });
    });
  }

  void _verifyOtp() {
    String otp = _controllers.map((controller) => controller.text).join();
    if (otp.length == 6) {
      // TODO: Add your OTP verification logic here
      print('Verifying OTP: $otp');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter all digits'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _resendOtp() {
    // Clear all OTP fields
    for (var controller in _controllers) {
      controller.clear();
    }
    // Focus on first field
    _focusNodes[0].requestFocus();

    // Start timer again
    startTimer();

    // TODO: Add your resend OTP API call here
    print('Resending OTP...');
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final verifyotp = context.read<VerifyOtpBloc>();
    
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(ResponsiveUtils.wp(6)),
        children: [
          SizedBox(
            height: ResponsiveUtils.hp(7),
          ),
          Container(
            height: ResponsiveUtils.hp(32),
            //width: ResponsiveUtils.hp(20),
            decoration: BoxDecoration(
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
          ResponsiveSizedBox.height30,
          TextStyles.subheadline(
            text: 'Enter OTP',
            color: Appcolors.kprimarycolor,
          ),
          ResponsiveSizedBox.height10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              6,
              (index) => SizedBox(
                width: 50,
                child: TextField(
                  cursorColor: Appcolors.kgreenColor,
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Appcolors.kgreenColor,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Appcolors.kgreenColor,
                        width: 1,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Appcolors.kgreenColor,
                        width: 1,
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      if (index < 5) {
                        _focusNodes[index + 1].requestFocus();
                      } else {
                        _focusNodes[index].unfocus();
                      }
                    } else if (value.isEmpty && index > 0) {
                      _focusNodes[index - 1].requestFocus();
                    }
                  },
                ),
              ),
            ),
          ),
          ResponsiveSizedBox.height10,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (_isTimerActive)
                Row(
                  children: [
                    TextStyles.caption(
                      text: 'Time remaining ',
                      color: Appcolors.kprimarycolor,
                      weight: FontWeight.w600,
                    ),
                    TextStyles.caption(
                      text:
                          '00:${_secondsRemaining.toString().padLeft(2, '0')}',
                      color: Appcolors.kredColor,
                      weight: FontWeight.w600,
                    ),
                  ],
                )
              else
                BlocConsumer<ResendOtpBloc, ResendOtpState>(
                  listener: (context, state) {
                    if (state is ResendOtpSuccessState) {
                      CustomSnackBar.show(
                          context: context,
                          title: 'Success',
                          message: 'Otp send successfully',
                          contentType: ContentType.success);
                    } else if (state is ResendOtpErrorState) {
                      CustomSnackBar.show(
                          context: context,
                          title: 'Error!',
                          message: state.message,
                          contentType: ContentType.failure);
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        _resendOtp();
                        context
                            .read<ResendOtpBloc>()
                            .add(ResendOtpClickEvent(userId: widget.userid));
                      },
                      child: TextStyles.caption(
                        text: 'Resend OTP',
                        color: Appcolors.kredColor,
                        weight: FontWeight.w600,
                      ),
                    );
                  },
                ),
            ],
          ),
          ResponsiveSizedBox.height20,
          BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
            listener: (context, state) {
              if (state is VerifyOtpSuccessState) {
                CustomNavigation.replace(
                    context,
                    ScreenResetPasswordpage(
                      userId: widget.userid,
                    ));
              } else if (state is VerifyOtpErrorState) {
                CustomSnackBar.show(
                    context: context,
                    title: 'Error!',
                    message: state.message,
                    contentType: ContentType.failure);
              }
            },
            builder: (context, state) {
              if (state is VerifyOtpLoadingState) {
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
                  String otp =
                      _controllers.map((controller) => controller.text).join();
                  if (otp.length == 6) {
                    verifyotp.add(
                        VerifyOtpclickEvent(otp: otp, userId: widget.userid));
                  } else {
                    CustomSnackBar.show(
                        context: context,
                        title: 'Error!',
                        message: 'Please Enter valid otp',
                        contentType: ContentType.failure);
                  }
                },
                text: 'Verify OTP',
              );
            },
          ),
        ],
      ),
    );
  }
}
