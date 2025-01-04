import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';

import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Appcolors.kprimarycolor.withOpacity(.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: ResponsiveUtils.wp(30),
                height: ResponsiveUtils.hp(15),
                child: Image.asset(
                  'assets/images/Aqua Green Logos-updated.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: TextStyles.body(
            text: 'Home',
            weight: FontWeight.w600,
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.track_changes),
          title: TextStyles.body(
            text: 'Add Measure',
            weight: FontWeight.w600,
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.bar_chart),
          title: TextStyles.body(
            text: 'View Report',
            weight: FontWeight.w600,
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: TextStyles.body(
            text: 'Profile',
            weight: FontWeight.w600,
          ),
          onTap: () {},
        ),
        const Divider(),
        Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.logout,
              ),
              title: TextStyles.body(
                text: 'Logout',
                weight: FontWeight.w600,
              ),
              onTap: () async {
                // // Define and call the clearAllData function directly
                // SharedPreferences preferences =
                //     await SharedPreferences.getInstance();
                // await preferences
                //     .clear(); // Clears everything in SharedPreferences

                // // Navigate to the Sign-In screen and remove all previous routes
                // Navigator.of(context).pushAndRemoveUntil(
                //   MaterialPageRoute(
                //       builder: (context) =>
                //           const AdvancedSplashScreen()),
                //   (route) => false,
                // );
              },
            ),
            SizedBox(
              height: ResponsiveUtils.hp(7),
            ),
            TextStyles.caption(text: 'Designed & Developed by'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextStyles.caption(
                    text: 'Crisant Technologies', weight: FontWeight.w600),
                TextStyles.caption(text: ', Mysuru'),
              ],
            )
          ],
        ),
      ],
    ));
  }
}
