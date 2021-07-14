import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/resources/assets.dart';

class WeatherDataRepository{
  static Future<Weather> getData() async {
    final response = await rootBundle.loadString(Assets.mockJsonData);
    final data = await jsonDecode(response);
    Weather mockWeather = Weather.fromJson(data);
    return mockWeather;
  }
}

