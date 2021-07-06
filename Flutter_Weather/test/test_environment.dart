import 'package:flutter_weather/environments/environment.dart';
import 'package:flutter_weather/packages/dahttp/dahttp.dart';

class TestEnvironment extends Environment {
  @override
  String get environment => 'test';

  @override
  String get scheme => 'http';

  @override
  String get subDomain => 'localhost:8080';

  @override
  String get baseHost => scheme + '://' + subDomain;

  @override
  bool get isDebug => true;

  @override
  HttpLogger get logger => DefaultHttpLogger(headers: true, body: true);
}
