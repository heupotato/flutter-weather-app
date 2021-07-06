import 'dart:convert';

import 'package:flutter_weather/environments/environment.dart';
import 'package:flutter_weather/packages/dahttp/dahttp.dart';
import 'package:http/http.dart';

class SecuredValuedEndPoint<T> extends ValuedHttpClient<T> {
  final T Function(Map<String, dynamic>)? objectConverter;
  final T Function(List<dynamic>)? listConverter;

  SecuredValuedEndPoint({this.objectConverter, this.listConverter})
      : super(logger: Environment.get.logger);

  @override
  Future<HttpResult<T>> get(
    String url, {
    String? host,
    Map<String, Object>? path,
    Map<String, Object>? query,
    Map<String, String>? headers,
    bool retry = true,
  }) async {
    final HttpResult<T> result = await super.get(
      url,
      host: Environment.get.host,
      path: path,
      query: query,
      headers: _headers(headers),
    );

    return result;
  }

  @override
  Future<HttpResult<T>> post(
    String url, {
    String? host,
    Map<String, Object>? path,
    Map<String, Object>? query,
    Map<String, String>? headers,
    dynamic body,
    Encoding? encoding,
    bool retry = true,
  }) async {
    final newHeaders = _headers(headers, body);

    final HttpResult<T> result = await super.post(
      url,
      host: Environment.get.host,
      path: path,
      query: query,
      headers: newHeaders,
      body: body,
      encoding: encoding,
    );

    return result;
  }

  @override
  Future<HttpResult<T>> put(
    String url, {
    String? host,
    Map<String, Object>? path,
    Map<String, Object>? query,
    Map<String, String>? headers,
    dynamic body,
    Encoding? encoding,
    bool retry = true,
  }) async {
    final newHeaders = _headers(headers, body);

    final HttpResult<T> result = await super.put(
      url,
      host: Environment.get.host,
      path: path,
      query: query,
      headers: newHeaders,
      body: body,
      encoding: encoding,
    );

    return result;
  }

  @override
  Future<HttpResult<T>> patch(
    String url, {
    String? host,
    Map<String, Object>? path,
    Map<String, Object>? query,
    Map<String, String>? headers,
    dynamic body,
    Encoding? encoding,
    bool retry = true,
  }) async {
    final newHeaders = _headers(headers, body);

    final HttpResult<T> result = await super.patch(
      url,
      host: Environment.get.host,
      path: path,
      query: query,
      headers: newHeaders,
      body: body,
      encoding: encoding,
    );

    return result;
  }

  @override
  Future<HttpResult<T>> delete(
    String url, {
    String? host,
    Map<String, Object>? path,
    Map<String, Object>? query,
    Map<String, String>? headers,
    bool retry = true,
  }) async {
    final newHeaders = _headers(headers);

    final HttpResult<T> result = await super.delete(
      url,
      host: Environment.get.host,
      path: path,
      query: query,
      headers: newHeaders,
    );

    return result;
  }

  Map<String, String> _headers(Map<String, String>? headers, [String? body]) {
    final newHeaders = headers ?? {};

    if (body != null) {
      newHeaders['Content-Type'] = 'application/json; charset=utf-8';
    }
    newHeaders['Accept-Language'] = 'en';

    return newHeaders;
  }

  @override
  T convert(Response response) {
    if (objectConverter != null) {
      return objectConverter!.call(jsonDecode(utf8.decode(response.bodyBytes)));
    } else if (listConverter != null) {
      return listConverter!.call(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Invalid HTTP client configuration');
    }
  }
}
