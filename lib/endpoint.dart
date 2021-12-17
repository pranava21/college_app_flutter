import 'dart:core';

class Endpoint {
  static const apiScheme = "http";
  static const apiHost = 'pranava.zapto.org';
  static const apiPort = 80;

  static Uri uri(String path, {required Map<String, dynamic> queryParameters}) {
    final uri = Uri(
        scheme: apiScheme,
        host: apiHost,
        port: apiPort,
        path: path,
        queryParameters: queryParameters);
    return uri;
  }
}
