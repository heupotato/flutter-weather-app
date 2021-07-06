import 'package:flutter_weather/app/weather_app.dart';
import 'package:flutter_weather/environments/environment_dev.dart';
import 'package:flutter_weather/resources/locator.dart';
import 'package:flutter/material.dart';

Future main() async {
  await initStateAndSetupEnvironment(DevEnvironment());
  runApp(const WeatherApp());
}
