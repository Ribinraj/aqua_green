import 'package:aqua_green/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:aqua_green/presentation/blocs/fetch_profile/fetch_profile_bloc.dart';
import 'package:aqua_green/presentation/screens/connectivity_page/connectivity_page.dart';
import 'package:aqua_green/presentation/screens/mainpage/widgets/customnavbar.dart';
import 'package:aqua_green/presentation/screens/screen_homepage/screen_homepage.dart';
import 'package:aqua_green/presentation/screens/screen_measurepage/screen_measurepage.dart';
import 'package:aqua_green/presentation/screens/screen_profilepage/screen_profilepage.dart';
import 'package:aqua_green/presentation/screens/screen_reportpage/screen_reportpage.dart';
import 'package:aqua_green/presentation/screens/screen_updateunits/update_units.dart';
import 'package:aqua_green/presentation/widgets/gps_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenMainPage extends StatefulWidget {
  const ScreenMainPage({super.key});

  @override
  State<ScreenMainPage> createState() => _ScreenMainPageState();
}

class _ScreenMainPageState extends State<ScreenMainPage> {
  final List<Widget> _pages = [
    ScreenHomepage(),
    ScreenUpdateUnits(),
    ScreenMeasurepage(),
    ScreenReportpage(),
    ScreenProfilepage()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FetchProfileBloc>().add(FetchProfileInitailEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return GpsCheckScreen(
          child: Scaffold(
            body: _pages[state.currentPageIndex],
            bottomNavigationBar: const BottomNavigationWidget(),
          ),
        );
      },
    );
  }
}
