import 'package:flutter/material.dart';

class ScreenReportpage extends StatefulWidget {
  const ScreenReportpage({super.key});

  @override
  State<ScreenReportpage> createState() => _ScreenReportpageState();
}

class _ScreenReportpageState extends State<ScreenReportpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text('Reportpage'),
      ),
    );
  }
}