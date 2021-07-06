import 'dart:io';

import 'package:flutter_weather/packages/dahttp/dahttp.dart';
import 'package:flutter_weather/resources/locator.dart';

bool get isTesting => Platform.environment.containsKey('FLUTTER_TEST');

abstract class Environment {
  String get environment;

  String get googlePlaceApiKey => 'AIzaSyDGFP5CjJnbLc02sVpkfE7UQA5OnDkQQCA';
  //'AIzaSyDw-QIM3Wq-VjpT-Mkt4JacPdHpDtfyDWI';

  String get scheme => 'https';

  String get host => 'hq.nestle.com';

  String get weatherHost => scheme + '://' + 'www.7timer.info';

  String get googlePlaceHost => scheme + '://' + 'maps.googleapis.com';

  String get googleCustomSearchHost => scheme + '://' + 'www.googleapis.com';

  bool get isDebug;

  HttpLogger get logger;

  static Environment get get => getIt<Environment>();
}
