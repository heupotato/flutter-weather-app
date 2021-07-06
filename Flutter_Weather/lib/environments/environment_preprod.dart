import 'package:flutter_weather/environments/environment.dart';
import 'package:flutter_weather/packages/dahttp/dahttp.dart';

class PreProdEnvironment extends Environment {
  @override
  String get environment => 'preprod';

  @override
  String get scheme => 'http';

  @override
  bool get isDebug => false;

  @override
  HttpLogger get logger => DefaultHttpLogger(headers: true, body: true);
}
