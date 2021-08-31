import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/packages/dahttp/dahttp.dart';
import 'package:flutter_weather/resources/assets.dart';
import 'package:http/src/response.dart';


class AutoCompleteRepository{
  static Future<Autocomplete> getMockData() async{
    final response = await rootBundle.loadString(Assets.mockAutocompleteData);
    final data = await jsonDecode(response);
    Autocomplete mockAutocomplete = Autocomplete.fromJson(data);
    return mockAutocomplete;
  }
}

class GetAutocompleteData extends ValuedHttpClient<Autocomplete>{
  Future<HttpResult<Autocomplete>> call(String place)
  => super.get('https://api.mapbox.com/geocoding/v5/mapbox.places/$place.json?access_token=pk.eyJ1IjoiaGV1cG90YXRvIiwiYSI6ImNrcmU5M3ppMDF6bnMybmxxdWZybnhnZ2EifQ.HipNHpiJeyatsN3dj4-zvA&autocomplete=true&types=region');

  @override
  Autocomplete convert(Response response) {
    final data = jsonDecode(response.body);
    Autocomplete autoCompleteData = Autocomplete.fromJson(data);
    return autoCompleteData;
  }

}