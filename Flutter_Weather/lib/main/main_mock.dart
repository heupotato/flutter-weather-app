import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_weather/app/weather_app.dart';
import 'package:flutter_weather/environments/environment_mock.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/resources/assets.dart';
import 'package:flutter_weather/resources/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/storage/repositories/places_repositories.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future main() async {
  await startMockServer();
  await initStateAndSetupEnvironment(MockEnvironment());
  final response = await rootBundle.loadString(Assets.mockDefaultPlace);
  final data = await jsonDecode(response);
  Place mockDefaultPlace = Place.fromJson(data);
  mockDefaultPlace.timeOffset = 7;
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(PlaceAdapter());
  Hive.registerAdapter(GeometryAdapter());
  await PlacesRepositories.loadBox();
  runApp(WeatherApp(place: await mockDefaultPlace));
}
