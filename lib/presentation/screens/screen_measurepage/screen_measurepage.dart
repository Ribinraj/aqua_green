import 'package:flutter/material.dart';

class ScreenMeasurepage extends StatefulWidget {
  const ScreenMeasurepage({super.key});

  @override
  State<ScreenMeasurepage> createState() => _ScreenMeasurepageState();
}

class _ScreenMeasurepageState extends State<ScreenMeasurepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text('Measurepage'),
      ),
    );
  }
}