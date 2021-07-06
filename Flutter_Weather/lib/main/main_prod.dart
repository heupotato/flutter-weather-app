import 'package:flutter_weather/app/weather_app.dart';
import 'package:flutter_weather/environments/environment_prod.dart';
import 'package:flutter_weather/resources/locator.dart';
import 'package:flutter/material.dart';

Future main() async {
  await initStateAndSetupEnvironment(ProdEnvironment());
  runApp(const WeatherApp());
}
