import 'package:aqua_green/core/colors.dart';

import 'package:aqua_green/core/responsive_utils.dart';

import 'package:aqua_green/presentation/widgets/custom_submitbutton.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

// class GpsCheckScreen extends StatefulWidget {
//   final Widget child;

//   const GpsCheckScreen({super.key, required this.child});

//   @override
//   State<GpsCheckScreen> createState() => _GpsCheckScreenState();
// }

// class _GpsCheckScreenState extends State<GpsCheckScreen> {
//   bool isGpsEnabled = false;

//   @override
//   void initState() {
//     super.initState();
//     checkGpsStatus();
//   }

//   Future<void> checkGpsStatus() async {
//     bool status = await LocationService.isGpsEnabled();
//     setState(() {
//       isGpsEnabled = status;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<ServiceStatus>(
//       stream: Geolocator.getServiceStatusStream(),
//       builder: (context, snapshot) {
//         if (!isGpsEnabled) {
//           return Scaffold(
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(
//                     Icons.location_off,
//                     size: 64,
//                     color: Colors.red,
//                   ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'GPS is disabled',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     'Please enable GPS to use this app',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 24),
//                   ElevatedButton(
//                     onPressed: () async {
//                       await Geolocator.openLocationSettings();
//                       checkGpsStatus();
//                     },
//                     child: const Text('Enable GPS'),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//         return widget.child;
//       },
//     );
//   }
// }

class GpsCheckScreen extends StatefulWidget {
  final Widget child;
  const GpsCheckScreen({super.key, required this.child});

  @override
  State<GpsCheckScreen> createState() => _GpsCheckScreenState();
}

class _GpsCheckScreenState extends State<GpsCheckScreen>
    with WidgetsBindingObserver {
  bool isGpsEnabled = false;
  late Stream<ServiceStatus> locationStream;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    locationStream = Geolocator.getServiceStatusStream();
    checkGpsStatus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkGpsStatus();
    }
  }

  Future<void> checkGpsStatus() async {
    final status = await Geolocator.isLocationServiceEnabled();
    setState(() {
      isGpsEnabled = status;
    });
  }

  Widget buildGpsWarning() {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: ResponsiveUtils.hp(20),
                width: ResponsiveUtils.wp(65),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/rb_221.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: ResponsiveUtils.hp(5)),
              Text(
                'Location Services Disabled',
                style: TextStyle(
                  fontSize: ResponsiveUtils.wp(5),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ResponsiveUtils.hp(2)),
              Text(
                'Please enable location services to use this app',
                style: TextStyle(
                  fontSize: ResponsiveUtils.wp(4),
                  color: Appcolors.kredColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SubmitButton(
                  ontap: () async {
                    await Geolocator.openLocationSettings();
                    checkGpsStatus();
                  },
                  text: 'Enable Location Service')
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ServiceStatus>(
      stream: locationStream,
      builder: (context, snapshot) {
        // Check stream updates
        if (snapshot.hasData) {
          isGpsEnabled = snapshot.data == ServiceStatus.enabled;
        }

        // Show warning if GPS is disabled
        if (!isGpsEnabled) {
          return buildGpsWarning();
        }

        // Show main content if GPS is enabled
        return widget.child;
      },
    );
  }
}
