import 'dart:io';

import 'package:flutter_weather/api/api.dart';
import 'package:flutter_weather/mock_data_providers/mock_autocomplete.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/packages/mockserver/mockserver.dart';

class AutoCompleteEndPoint extends EndPoint {
  AutoCompleteEndPoint()
      : super(
          method: Method.GET,
          path: UserApi.GET_AUTOCOMPLETE,
        );

  @override
  void process(HttpRequest request, HttpResponse response) async {
    final defaultInput = 'paris';
    final String input = (request.queryParameters['input'] ?? defaultInput)
        .toLowerCase()
        .replaceAll(RegExp(' '), '');
    final Autocomplete autocomplete =
        await MockAutocomplete.autocomplete(input);
    response.fill(
      statusCode: HttpStatusCode.OK,
      json: autocomplete,
    );
  }
}
