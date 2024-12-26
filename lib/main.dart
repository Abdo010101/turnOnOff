import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const platform = MethodChannel('com.example.screen_control_app/screen');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        
        appBar: AppBar(title: Text('Screen Control')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _lockScreen,
                child: Text('Lock Screen'),
              ),
              ElevatedButton(
                onPressed: _unlockScreen,
                child: Text('Unlock Screen'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to lock the screen
  Future<void> _lockScreen() async {
    try {
      final String result = await platform.invokeMethod('lockScreen');
      print(result);  // Should print "Screen locked"
    } on PlatformException catch (e) {
      print("Failed to lock screen: ${e.message}");
    }
  }

  // Method to unlock the screen
  Future<void> _unlockScreen() async {
    try {
      final String result = await platform.invokeMethod('unlockScreen');
      print(result);  // Should print "Screen unlocked"
    } on PlatformException catch (e) {
      print("Failed to unlock screen: ${e.message}");
    }
  }
}
