import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';
import 'package:aqua_green/presentation/screens/signin_page/screen_signinpage.dart';
import 'package:aqua_green/presentation/widgets/custom_navigator.dart';
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
      navigate(context);
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

  Future<void> navigate(BuildContext context) async {
    CustomNavigation.replace(
      context,
      const ScreenSigninPage(),
    );
  }
}
