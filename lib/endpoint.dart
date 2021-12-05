import 'dart:core';

class Endpoint {
  static const apiScheme = "http";
  static const apiHost = '192.168.0.205';
  static const apiPort = 7103;

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
