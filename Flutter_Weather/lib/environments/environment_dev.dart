import 'package:flutter_weather/environments/environment.dart';
import 'package:flutter_weather/packages/dahttp/dahttp.dart';

class DevEnvironment extends Environment {
  @override
  String get environment => 'dev';

  @override
  bool get isDebug => false;

  @override
  HttpLogger get logger => DefaultHttpLogger(headers: true, body: true);
}
