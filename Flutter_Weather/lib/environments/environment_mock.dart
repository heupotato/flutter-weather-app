import 'package:flutter_weather/environments/environment.dart';
import 'package:flutter_weather/packages/dahttp/dahttp.dart';

class MockEnvironment extends Environment {
  @override
  String get environment => 'mock';

  @override
  String get scheme => 'http';

  //String get weatherHost => scheme + '://' + 'localhost:8080';

  String get googlePlaceHost => scheme + '://' + 'localhost:8080';

  String get googleCustomSearchHost => scheme + '://' + 'localhost:8080';

  @override
  bool get isDebug => true;

  @override
  HttpLogger get logger => DefaultHttpLogger(headers: true, body: true);
}
