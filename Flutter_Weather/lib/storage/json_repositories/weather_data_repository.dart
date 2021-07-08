import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/resources/assets.dart';

class WeatherDataRepository{
  static Future<Mockjsondata> printJson() async {
    final response = await rootBundle.loadString(Assets.mockJsonData);
    final data = await jsonDecode(response);
    Mockjsondata mockdata = Mockjsondata.fromJson(data);
    return mockdata;
  }
}