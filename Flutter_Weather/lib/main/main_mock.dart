import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_weather/app/weather_app.dart';
import 'package:flutter_weather/environments/environment_mock.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/resources/assets.dart';
import 'package:flutter_weather/resources/locator.dart';
import 'package:flutter/material.dart';

Future main() async {
  await startMockServer();
  await initStateAndSetupEnvironment(MockEnvironment());
  final response = await rootBundle.loadString(Assets.mockDefaultPlace);
  final data = await jsonDecode(response);
  Place mockDefaultPlace = Place.fromJson(data);
  runApp(WeatherApp(place: await mockDefaultPlace));
}
