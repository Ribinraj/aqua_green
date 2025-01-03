import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/responsive_utils.dart';
import 'package:aqua_green/presentation/screens/splash_page/screen_splashpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      ResponsiveUtils().init(context);
    return MaterialApp(
      title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
                surfaceTintColor: Appcolors.kwhiteColor,
                backgroundColor: Appcolors.kwhiteColor),
            fontFamily: GoogleFonts.montserrat().fontFamily,
            scaffoldBackgroundColor: Appcolors.kbackgroundcolor,
            useMaterial3: true,
      ),
      home: ScreenSplashPage(),
    );
  }
}

