import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/resources/assets.dart';


class AutoCompleteRepository{
  static Future<AutocompleteCity> getData() async{
    final response = await rootBundle.loadString(Assets.mockAutocompleteData);
    final data = await jsonDecode(response);
    AutocompleteCity mockAutocomplete = AutocompleteCity.fromJson(data);
    return mockAutocomplete;
  }
}