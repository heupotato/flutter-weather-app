import 'package:flutter_weather/environments/environment.dart';
import 'package:flutter_weather/packages/dahttp/dahttp.dart';

class ProdEnvironment extends Environment {
  @override
  String get environment => 'prod';

  @override
  bool get isDebug => false;

  @override
  HttpLogger get logger => DefaultHttpLogger(headers: true, body: true);
}
