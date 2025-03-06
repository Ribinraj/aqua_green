import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/responsive_utils.dart';
import 'package:aqua_green/domain/database/measurment_savedatabase.dart';
import 'package:aqua_green/domain/repositories/login_repo.dart';
import 'package:aqua_green/domain/repositories/measurments_repo.dart';
import 'package:aqua_green/presentation/blocs/add_measurment/add_measurment_bloc.dart';
import 'package:aqua_green/presentation/blocs/fetch_report_offline/fetch_report_offline_bloc.dart';
import 'package:aqua_green/presentation/blocs/update_profile/update_profile_bloc.dart';
import 'package:aqua_green/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:aqua_green/presentation/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:aqua_green/presentation/blocs/cubit/toggle_password_cubit.dart';
import 'package:aqua_green/presentation/blocs/fetch_area/fetch_area_bloc.dart';
import 'package:aqua_green/presentation/blocs/fetch_profile/fetch_profile_bloc.dart';
import 'package:aqua_green/presentation/blocs/fetch_reportbloc/fetch_report_bloc.dart';
import 'package:aqua_green/presentation/blocs/fetch_route/fetch_route_bloc.dart';
import 'package:aqua_green/presentation/blocs/fetch_unit/fetch_unit_bloc.dart';
import 'package:aqua_green/presentation/blocs/image_picker/image_picker_bloc.dart';
import 'package:aqua_green/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:aqua_green/presentation/blocs/otp_bloc/otp_bloc_bloc.dart';
import 'package:aqua_green/presentation/blocs/resend_otp/resend_otp_bloc.dart';
import 'package:aqua_green/presentation/blocs/update_password/update_password_bloc.dart';
import 'package:aqua_green/presentation/blocs/update_unit/update_units_bloc.dart';
import 'package:aqua_green/presentation/blocs/verify_otpbloc/verify_otp_bloc.dart';
import 'package:aqua_green/presentation/screens/splash_page/screen_splashpage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
  // Connectivity().onConnectivityChanged.listen((results) {
  //   if (results.contains(ConnectivityResult.mobile) ||
  //       results.contains(ConnectivityResult.wifi)) {
  //     MeasurmentsRepo().syncPendingData();
  //   }
  // });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ResponsiveUtils().init(context);
    final loginrepo = Loginrepo();
    final measurmentrepo = MeasurmentsRepo();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TogglePasswordCubit(),
        ),
        BlocProvider(
          create: (context) => BottomNavigationBloc(),
        ),
        BlocProvider(
          create: (context) => ImagePickerBloc(),
        ),
        BlocProvider(
          create: (context) => ConnectivityBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(repository: loginrepo),
        ),
        BlocProvider(
          create: (context) => OtpBlocBloc(repository: loginrepo),
        ),
        BlocProvider(
          create: (context) => VerifyOtpBloc(repository: loginrepo),
        ),
        BlocProvider(
          create: (context) => ResendOtpBloc(repository: loginrepo),
        ),
        BlocProvider(
          create: (context) => UpdatePasswordBloc(repository: loginrepo),
        ),
        BlocProvider(
          create: (context) => FetchRouteBloc(repository: measurmentrepo),
        ),
        BlocProvider(
          create: (context) => FetchAreaBloc(repository: measurmentrepo),
        ),
        BlocProvider(
          create: (context) => FetchUnitBloc(repository: measurmentrepo),
        ),
        BlocProvider(
          create: (context) => UpdateUnitsBloc(repository: measurmentrepo),
        ),
        BlocProvider(
          create: (context) => AddMeasurmentBloc(repository: measurmentrepo),
        ),
        BlocProvider(
          create: (context) => FetchReportBloc(repository: measurmentrepo),
        ),
        BlocProvider(
          create: (context) => FetchProfileBloc(repository: loginrepo),
        ),
        BlocProvider(
          create: (context) => UpdateProfileBloc(repository: loginrepo),
        ),
         BlocProvider(
          create: (context) => FetchReportOfflineBloc(waterplantdatabasehelper: WaterPlantDatabaseHelper.instance),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
