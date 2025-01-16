import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';
import 'package:aqua_green/presentation/blocs/fetch_profile/fetch_profile_bloc.dart';
import 'package:aqua_green/presentation/screens/screen_editprofile/screen_editprofilepage.dart';
import 'package:aqua_green/presentation/screens/signin_page/screen_signinpage.dart';

import 'package:aqua_green/presentation/widgets/custom_navigator.dart';
import 'package:aqua_green/presentation/widgets/custom_submitbutton.dart';
import 'package:aqua_green/presentation/widgets/customrout_mainpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenProfilepage extends StatefulWidget {
  const ScreenProfilepage({super.key});

  @override
  State<ScreenProfilepage> createState() => _ScreenProfilepageState();
}

class _ScreenProfilepageState extends State<ScreenProfilepage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FetchProfileBloc>().add(FetchProfileInitailEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<FetchProfileBloc, FetchProfileState>(
      builder: (context, state) {
        if (state is FetchProfileLoadingState) {
          return const Center(
            child: SpinKitWaveSpinner(color: Appcolors.kprimarycolor),
          );
        } else if (state is FetchProfileSuccessState) {
          return ListView(
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
                    nameContainer(text: state.user.userFullName),
                    ResponsiveSizedBox.height20,
                    TextStyles.medium(
                        text: 'Mobile Number',
                        weight: FontWeight.bold,
                        color: Appcolors.kprimarycolor),
                    ResponsiveSizedBox.height5,
                    nameContainer(text:state.user.userMobileNumber),
                    ResponsiveSizedBox.height20,
                    Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: BeveledRectangleBorder(),
                                  title: TextStyles.subheadline(
                                      text: 'Logout',
                                      color: Appcolors.kprimarycolor),
                                  content: TextStyles.medium(
                                      text:
                                          "Are you sure you want to sign out?",
                                      weight: FontWeight.bold,
                                      color: Appcolors.kblackColor),
                                  actions: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        width: ResponsiveUtils.wp(12),
                                        height: ResponsiveUtils.hp(3),
                                        color: Appcolors.kgreenColor,
                                        child: Center(
                                            child: TextStyles.medium(
                                                text: 'No',
                                                color: Appcolors.kwhiteColor,
                                                weight: FontWeight.bold)),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        await preferences.clear();
                                        Navigator.of(context).pop();
                                        navigateToMainPage(context, 0);
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ScreenSigninPage()),
                                          (Route<dynamic> route) =>
                                              false, // Remove all previous routes
                                        );

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text("You have signed out!")),
                                        );
                                      },
                                      child: Container(
                                        width: ResponsiveUtils.wp(12),
                                        height: ResponsiveUtils.hp(3),
                                        color: Appcolors.kredColor,
                                        child: Center(
                                            child: TextStyles.medium(
                                                text: 'Yes',
                                                color: Appcolors.kwhiteColor,
                                                weight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: TextStyles.medium(
                              text: 'Logout',
                              weight: FontWeight.bold,
                              color: Appcolors.kredColor),
                        ),
                        ResponsiveSizedBox.width10,
                      ],
                    )
                  ],
                ),
              ),
              ResponsiveSizedBox.height30,
              SubmitButton(
                  ontap: () {
                    CustomNavigation.push(
                        context,  ScreenEditProfilepage(fullname:state.user.userFullName,));
                  },
                  text: 'Edit')
            ],
          );
        } else if (state is FetchProfileErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return SizedBox.shrink();
        }
      },
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
        style: const TextStyle(
          fontSize: 11,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
