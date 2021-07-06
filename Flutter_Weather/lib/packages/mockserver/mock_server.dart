import 'dart:io';

import 'package:flutter_weather/packages/mockserver/mockserver.dart';

class MockServer {
  final int port;
  final List<EndPoint> endPoints;
  final int endPointDelay;
  late HttpServer _server;

  MockServer({
    this.port = 8080,
    this.endPoints = const <EndPoint>[],
    this.endPointDelay = 0,
  });

  Future start() async {
    try {
      _server = await HttpServer.bind(InternetAddress.anyIPv6, port);
      _server.listen(_onRequest);
    } catch (e) {}
  }

  Future stop() => _server.close();

  void _onRequest(HttpRequest request) {
    final HttpResponse response = request.response;

    try {
      final EndPoint? endPoint = _endPoint(request.method, request.uri.path);

      if (endPoint != null) {
        endPoint.processRequest(request, response, endPointDelay);
      } else {
        response.statusCode = HttpStatusCode.NOT_FOUND;
        response.close();
      }
    } catch (e) {
      print(e.toString());

      response.statusCode = HttpStatusCode.INTERNAL_SERVER_ERROR;
      response.close();
    }
  }

  EndPoint? _endPoint(String method, String path) {
    for (final EndPoint endPoint in endPoints) {
      if (!endPoint.hasPathParameters && endPoint.match(method, path)) {
        return endPoint;
      }
    }

    for (final EndPoint endPoint in endPoints) {
      if (endPoint.match(method, path)) {
        return endPoint;
      }
    }

    return null;
  }
}
