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
  Future<HttpResult<Weather>> call(double lon, double lat) =>
    super.get('http://www.7timer.info/bin/api.pl?lon=$lon&lat=$lat&product=civil&output=json');

  @override
  convert(Response response) {
    final data = jsonDecode(response.body);
    Weather retrievedWeather = Weather.fromJson(data);
    return retrievedWeather;
  }
}

class GetTimezone extends ValuedHttpClient<Timezone>{
  Future<HttpResult<Timezone>> call(double lon, double lat)
   => super.get('https://api.ipgeolocation.io/timezone?apiKey=c50e96f376934e12bae30c54317abe91&lat=$lat&long=$lon');


  @override
  convert(Response response) {
    final data = jsonDecode(response.body);
    Timezone retrievedTimezone = Timezone.fromJson(data);
    return retrievedTimezone;
  }
}

