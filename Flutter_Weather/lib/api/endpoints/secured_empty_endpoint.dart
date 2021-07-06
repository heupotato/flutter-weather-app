import 'package:flutter_weather/api/endpoints/secured_valued_endpoint.dart';
import 'package:http/http.dart';

class SecuredEmptyEndPoint extends SecuredValuedEndPoint<void> {
  @override
  void convert(Response response) {}
}
