import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';
import 'package:aqua_green/presentation/screens/mainpage/screen_mainpage.dart';
import 'package:aqua_green/presentation/screens/signin_page/screen_signinpage.dart';
import 'package:aqua_green/presentation/widgets/custom_navigator.dart';
import 'package:aqua_green/presentation/widgets/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ScreenSplashPage extends StatefulWidget {
  const ScreenSplashPage({super.key});

  @override
  State<ScreenSplashPage> createState() => _ScreenSplashPageState();
}

class _ScreenSplashPageState extends State<ScreenSplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      checkUserlogin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: ResponsiveUtils.hp(20),
              width: ResponsiveUtils.wp(45),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('assets/images/Aqua Green Logos-updated.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            ResponsiveSizedBox.height20,
            SpinKitCircle(
              color: Appcolors.kgreenColor,
              size: ResponsiveUtils.wp(10),
            )
          ],
        ),
      ),
    );
  }

  Future<void> checkUserlogin(context) async {
    final String usertoken = await getUserToken();
    if (usertoken.isEmpty) {
      await Future.delayed(const Duration(seconds: 3));
      CustomNavigation.replace(context, ScreenSigninPage());
    } else {
      CustomNavigation.replace(context, ScreenMainPage());
    }
  }
}
// import 'package:aqua_green/core/colors.dart';
// import 'package:aqua_green/core/constants.dart';
// import 'package:aqua_green/core/responsive_utils.dart';
// import 'package:aqua_green/presentation/blocs/fetch_profile/fetch_profile_bloc.dart';
// import 'package:aqua_green/presentation/screens/mainpage/screen_mainpage.dart';
// import 'package:aqua_green/presentation/screens/signin_page/screen_signinpage.dart';
// import 'package:aqua_green/presentation/widgets/custom_navigator.dart';
// import 'package:aqua_green/presentation/widgets/shared_preference.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// class ScreenSplashPage extends StatefulWidget {
//   const ScreenSplashPage({super.key});

//   @override
//   State<ScreenSplashPage> createState() => _ScreenSplashPageState();
// }

// class _ScreenSplashPageState extends State<ScreenSplashPage> {
//   @override
//   void initState() {
//     super.initState();
//     // Directly start profile fetch if token exists
//     checkAndFetchProfile();
//   }

//   Future<void> checkAndFetchProfile() async {
//     final String userToken = await getUserToken();
//     if (mounted) {
//       if (userToken.isEmpty) {
//         CustomNavigation.replace(context, ScreenSigninPage());
//       } else {
//         // Directly trigger profile fetch if token exists
//         context.read<FetchProfileBloc>().add(FetchProfileInitailEvent());
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocConsumer<FetchProfileBloc, FetchProfileState>(
//         listener: (context, state) {
//           if (state is FetchProfileSuccessState) {
//             CustomNavigation.replace(context, ScreenMainPage());
//           } else if (state is FetchProfileErrorState) {
//             CustomNavigation.replace(context, ScreenSigninPage());
//           }
//         },
//         builder: (context, state) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   height: ResponsiveUtils.hp(20),
//                   width: ResponsiveUtils.wp(45),
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(
//                           'assets/images/Aqua Green Logos-updated.png'),
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//                 ResponsiveSizedBox.height20,
//                 SpinKitCircle(
//                   color: Appcolors.kgreenColor,
//                   size: ResponsiveUtils.wp(10),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }