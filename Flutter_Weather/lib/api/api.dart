import 'dart:convert';
import 'package:http/http.dart';

abstract class Api {
  static const PATH = '/appl_brs1/api';

  static int errorCode(Response response) {
    try {
      final String data = response.body;

      if (data.isNotEmpty) {
        final json = jsonDecode(data);

        if (json['error'] != null) {
          return json['error'] as int;
        }
      }
    } catch (e) {
      try {
        final errorCode = response.headers['Error-Code'];

        if (errorCode != null) {
          return int.parse(errorCode);
        }
      } catch (e) {
        // ignore
      }
    }

    return 0;
  }
}

abstract class UserApi {
  static const GET_USERS = '${Api.PATH}/users';
  static const GET_META = '${Api.PATH}/meta';
  static const GET_PING = '${Api.PATH}/ping';
  static const CREATE_ORDERS = '${Api.PATH}/orders';
  static const GET_AUTOCOMPLETE = '/maps/api/place/autocomplete/json';
  static const GET_PLACE_DETAIL = '/maps/api/place/details/json';
  static const GET_PLACE_PHOTO = '/customsearch/v1';
  static const GET_WEATHER = '/bin/api.pl';
}
