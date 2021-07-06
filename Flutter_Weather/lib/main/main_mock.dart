import 'package:flutter_weather/app/weather_app.dart';
import 'package:flutter_weather/environments/environment_mock.dart';
import 'package:flutter_weather/resources/locator.dart';
import 'package:flutter/material.dart';

Future main() async {
  await startMockServer();
  await initStateAndSetupEnvironment(MockEnvironment());
  runApp(const WeatherApp());
}
