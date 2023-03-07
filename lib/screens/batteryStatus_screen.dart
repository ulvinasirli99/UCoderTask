import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class BatteryStatusScreen extends StatefulWidget {
  const BatteryStatusScreen({super.key});

  @override
  State<BatteryStatusScreen> createState() => _BatteryStatusScreenState();
}

class _BatteryStatusScreenState extends State<BatteryStatusScreen> {
  String _batteryLevel = 'Unknown';
  MethodChannel platform = MethodChannel('uCoders/battery');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your battery level is $_batteryLevel',textAlign: TextAlign.center,),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
             onPressed: _getBatteryLevel,
              child: Text("Check Battery Level"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = '$result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
}
