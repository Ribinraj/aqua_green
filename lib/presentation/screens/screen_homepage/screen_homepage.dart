import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/presentation/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class ScreenHomepage extends StatefulWidget {
  const ScreenHomepage({super.key});

  @override
  State<ScreenHomepage> createState() => _ScreenHomepageState();
}

class _ScreenHomepageState extends State<ScreenHomepage> {
  GoogleMapController? mapController;
  Position? currentPosition;

  // Initial camera position (will be updated with current location)
  static const CameraPosition initialPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.0,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Function to get location permission and current position
  Future<void> _getCurrentLocation() async {
    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Handle denied permission
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Handle permanently denied permission
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition();

      setState(() {
        currentPosition = position;
      });

      // Move camera to current position
      if (mapController != null && currentPosition != null) {
        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                currentPosition!.latitude,
                currentPosition!.longitude,
              ),
              zoom: 15.0,
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        title: TextStyles.body(
            weight: FontWeight.bold,
            text: 'Hii Crisant',
            color: Appcolors.kprimarycolor),
        // actions: [
        //   // Add refresh button to get current location again
        //   IconButton(
        //     icon: const Icon(Icons.my_location),
        //     onPressed: _getCurrentLocation,
        //   ),
        // ],
      ),
      drawer: const CustomDrawer(),
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
          // Get location when map is created
          _getCurrentLocation();
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
      ),
    );
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }
}
