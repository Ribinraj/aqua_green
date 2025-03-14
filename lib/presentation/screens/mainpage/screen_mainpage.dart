import 'package:aqua_green/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:aqua_green/presentation/blocs/fetch_profile/fetch_profile_bloc.dart';

import 'package:aqua_green/presentation/screens/mainpage/widgets/customnavbar.dart';
import 'package:aqua_green/presentation/screens/screen_homepage/screen_homepage.dart';
import 'package:aqua_green/presentation/screens/screen_measurepage/screen_measurepage.dart';
import 'package:aqua_green/presentation/screens/screen_profilepage/screen_profilepage.dart';
import 'package:aqua_green/presentation/screens/screen_reportpage/screen_reportpage.dart';
import 'package:aqua_green/presentation/screens/screen_updateunits/update_units.dart';
import 'package:aqua_green/presentation/widgets/gps_widget.dart';
import 'package:aqua_green/presentation/widgets/sync_progress.dart';
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
            body: Stack(children:[ _pages[state.currentPageIndex],
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: StreamBuilder<SyncProgressState>(
                  stream: SyncProgress().syncProgressStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || !snapshot.data!.isSyncing) {
                      return const SizedBox.shrink();
                    }

                    final progress = snapshot.data!;
                    return Container(
                      color: Colors.black54,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LinearProgressIndicator(
                              value: progress.progress,
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Syncing ${progress.completedItems}/${progress.totalItems}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),]),
            bottomNavigationBar: const BottomNavigationWidget(),
          ),
        );
      },
    );
  }
}
