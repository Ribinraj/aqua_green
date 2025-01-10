import 'package:aqua_green/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:aqua_green/presentation/screens/connectivity_page/connectivity_page.dart';
import 'package:aqua_green/presentation/screens/mainpage/widgets/customnavbar.dart';
import 'package:aqua_green/presentation/screens/screen_homepage/screen_homepage.dart';
import 'package:aqua_green/presentation/screens/screen_measurepage/screen_measurepage.dart';
import 'package:aqua_green/presentation/screens/screen_profilepage/screen_profilepage.dart';
import 'package:aqua_green/presentation/screens/screen_reportpage/screen_reportpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({super.key});

  final List<Widget> _pages = [
    ScreenHomepage(),
    ScreenMeasurepage(),
    ScreenReportpage(),
    ScreenProfilepage()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return ConnectivityAwareWidget(
          child: Scaffold(
            body: _pages[state.currentPageIndex],
            bottomNavigationBar: const BottomNavigationWidget(),
          ),
        );
      },
    );
  }
}
