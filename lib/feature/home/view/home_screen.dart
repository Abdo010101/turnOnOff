import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const platform =
      MethodChannel('com.example.screen_control_app/screen');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen Control App')),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                _turnOffChannedMeghod();
              },
              child: Text("Turn on")),
          ElevatedButton(
              onPressed: () {
                _turnOnScreen();
              },
              child: Text("Turn off")),
        ],
      ),
    );
  }

  void _turnOffChannedMeghod() async {
    try {
      final String res = await platform.invokeMethod('lockScreen');
      log(res.toString());
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

// Method to turn on the screen
  Future<void> _turnOnScreen() async {
    try {
      final String result = await platform.invokeMethod('unlockScreen');
      print(result); // Should print: Screen turned on
    } on PlatformException catch (e) {
      print("Failed to turn on screen: ${e.message}");
    }
  }
}
