import 'package:flutter/material.dart';

class ScreenSigninPage extends StatefulWidget {
  const ScreenSigninPage({super.key});

  @override
  State<ScreenSigninPage> createState() => _ScreenSigninPageState();
}

class _ScreenSigninPageState extends State<ScreenSigninPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: Text('signin page'),
    ),);
  }
}