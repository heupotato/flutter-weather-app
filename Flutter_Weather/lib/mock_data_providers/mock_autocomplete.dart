import 'dart:convert';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter/services.dart' show rootBundle;

class MockAutocomplete {
  static Future<Map<String, dynamic>> readJson(String input) async {
    final String response =
        await rootBundle.loadString('assets/jsons/${input}_autocomplete.json');
    return await jsonDecode(response);
  }

  static Future<Autocomplete> autocomplete(String input) async {
    final defaultInput = 'paris';
    Map<String, dynamic>? json;
    try {
      json = await readJson(input);
    } catch (e) {}
    if (json == null) {
      json = await readJson(defaultInput);
    }
    return Autocomplete.fromJson(json);
  }
}
