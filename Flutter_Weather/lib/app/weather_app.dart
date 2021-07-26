import 'package:flutter_weather/resources/palette.dart';
import 'package:flutter_weather/routes/routes.dart';
import 'package:flutter_weather/screens/home_screen.dart';
import 'package:flutter/material.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: _color(),
          primaryColor: Palette.white,
          canvasColor: Palette.primary,
          backgroundColor: Palette.primary,
          scaffoldBackgroundColor: Palette.primary),
      navigatorKey: Routes.navigatorStateKey,
      home: HomeScreen(),
    );
  }

  MaterialColor _color() {
    return MaterialColor(
      Palette.primary.value,
      <int, Color>{
        50: Palette.primary,
        100: Palette.primary,
        200: Palette.primary,
        300: Palette.primary,
        400: Palette.primary,
        500: Palette.primary,
        600: Palette.primary,
        700: Palette.primary,
        800: Palette.primary,
        900: Palette.primary,
      },
    );
  }
}
