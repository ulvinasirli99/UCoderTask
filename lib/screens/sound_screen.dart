import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SoundScreen extends StatefulWidget {
  const SoundScreen({super.key});

  @override
  State<SoundScreen> createState() => _SoundScreenState();
}

class _SoundScreenState extends State<SoundScreen> {
  MethodChannel channel = MethodChannel('uCoders/soundPlayer');

  bool isPlayed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            setState(() {
              isPlayed = !isPlayed;
            });
            if (isPlayed) {
              await playSound();
            } else {
              stopSound();
            }
          },
          child: Text(isPlayed == false ? "Play Sound" : "Stop Sound"),
        ),
      ),
    );
  }

  Future<void> playSound() async {
    isPlayed = true;
    await channel.invokeMethod('playSound');
    setState(() {});
  }

  Future<void> stopSound() async {
    isPlayed = false;
    await channel.invokeMethod('stopSound');
    setState(() {});
  }
}
