import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/packages/dahttp/dahttp.dart';
import 'package:flutter_weather/resources/assets.dart';
import 'package:http/src/response.dart';

class WeatherDataRepository {
  static Future<Weather> getData() async {
    final response = await rootBundle.loadString(Assets.mockJsonData);
    final data = await jsonDecode(response);
    Weather mockWeather = Weather.fromJson(data);
    return mockWeather;
  }
}

class GetWeatherDataCity extends ValuedHttpClient<Weather>{
  Future<HttpResult<Weather>> call() => 
    super.get('http://www.7timer.info/bin/api.pl?lon=113.17&lat=23.09&product=civil&output=json');

  @override
  convert(Response response) async{
    final data = await jsonDecode(response.body);
    Weather retrievedWeather = Weather.fromJson(data);
    return retrievedWeather;
  }
  
}

