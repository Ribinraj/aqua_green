
import 'package:aqua_green/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:aqua_green/presentation/screens/mainpage/screen_mainpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void navigateToMainPage(BuildContext context, int pageIndex) {
  // Navigate to ScreenMainPage
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => ScreenMainPage()),
  );

  // After navigation, update the BLoC to show the desired page
  BlocProvider.of<BottomNavigationBloc>(context).add(
    NavigateToPageEvent(pageIndex: pageIndex),
  );
}