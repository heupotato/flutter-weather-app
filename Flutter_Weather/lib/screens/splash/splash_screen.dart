import 'package:flutter_weather/resources/palette.dart';
import 'package:flutter_weather/services/logger.dart';
import 'package:flutter_weather/widgets/labels/label.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Logger.logInfo(
        className: '_SplashScreenState',
        methodName: 'initState',
        message: 'Open splash orders');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
             Container(
                  color: Palette.primary,
                  child: Center(child: Label(text: 'FLUTTER WEATHER')),
            )
          ],
        ));
  }
}
