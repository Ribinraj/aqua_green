// import 'package:aqua_green/core/colors.dart';
// import 'package:aqua_green/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class BottomNavigationWidget extends StatelessWidget {
//   const BottomNavigationWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
//       builder: (context, state) {
//         return BottomNavigationBar(
//           currentIndex: state.currentPageIndex,
//           onTap: (index) {
//             context.read<BottomNavigationBloc>().add(
//                   NavigateToPageEvent(pageIndex: index),
//                 );
//           },
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: Appcolors.kwhiteColor,
//           selectedItemColor: Appcolors.kgreenColor,
//           unselectedItemColor: Appcolors.kprimarycolor,
//           selectedIconTheme: const IconThemeData(color: Appcolors.kgreenColor),
//           unselectedIconTheme:
//               const IconThemeData(color: Appcolors.kprimarycolor),
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(CupertinoIcons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.track_changes),
//               label: 'Add Measure',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.bar_chart),
//               label: 'View Report',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person_2_outlined),
//               label: 'Profile',
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/responsive_utils.dart';
import 'package:aqua_green/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.currentPageIndex,
          onTap: (index) {
            context.read<BottomNavigationBloc>().add(
                  NavigateToPageEvent(pageIndex: index),
                );
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Appcolors.kwhiteColor,
          selectedItemColor: Appcolors.kprimarycolor,
          unselectedItemColor: Appcolors.kgreyColor,
          selectedLabelStyle:
              const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          unselectedLabelStyle:
              TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          items: [
            _buildNavigationBarItem(
              context,
              index: 0,
              icon: CupertinoIcons.home,
              label: 'Home',
              isSelected: state.currentPageIndex == 0,
            ),
               _buildNavigationBarItem(
              context,
              index: 1,
              icon: Icons.ad_units,
              label: 'Update Unit',
              isSelected: state.currentPageIndex == 1,
            ),
            _buildNavigationBarItem(
              context,
              index: 1,
              icon: Icons.track_changes,
              label: 'Measure',
              isSelected: state.currentPageIndex == 2,
            ),
            _buildNavigationBarItem(
              context,
              index: 2,
              icon: Icons.bar_chart,
              label: 'Report',
              isSelected: state.currentPageIndex == 3,
            ),
            _buildNavigationBarItem(
              context,
              index: 3,
              icon: Icons.person_2_outlined,
              label: 'Profile',
              isSelected: state.currentPageIndex == 4,
            ),
          ],
        );
      },
    );
  }

  BottomNavigationBarItem _buildNavigationBarItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: isSelected
          ? Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: ResponsiveUtils.wp(9),
                  height: ResponsiveUtils.wp(9),
                  decoration: const BoxDecoration(
                    color: Appcolors.kprimarycolor,
                    shape: BoxShape.circle,
                  ),
                ),
                Icon(
                  icon,
                  color: Colors.white,
                ),
              ],
            )
          : Icon(icon),
      label: label,
    );
  }
}
