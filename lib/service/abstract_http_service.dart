import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:team_manager/environment_config.dart';

import '../domain/abstract.domain.dart';
import 'interface_interceptor.dart';
import 'interface_service.dart';

/// Abstract CRUD service through HTTP.
/// @author JPOLIVE
abstract class AbstractHttpService<T extends AbstractDomain<U>, U> implements InterfaceService<T, U> {

  AbstractHttpService({required this.path, this.useHttps = false, this.interceptor, this.defaultHeaders}) {
    if (EnvironmentConfig.serverUrl == null || EnvironmentConfig.serverUrl.isEmpty == true) {

    }
  }

  http.Response _defaultTimeoutResponse = http.Response('Timeout exception', 408);

  setDefaultTimeoutResponse(http.Response? httpTimeoutResponse) {
    _defaultTimeoutResponse = httpTimeoutResponse ?? _defaultTimeoutResponse;
    return this;
  }

  Duration _defaultTimeoutDuration = const Duration(seconds: 5);

  setDefaultTimeoutDuration(Duration? duration) {
    _defaultTimeoutDuration = duration ?? _defaultTimeoutDuration;
    return this;
  }

  /// The URL of the resource.
  String path;

  /// If the service should use HTTPS instead of HTTP.
  /// Default to FALSE to use HTTP.
  bool useHttps;

  /// Optional : Default headers to send with all the requests of this service.
  /// If headers are passed at the method level, merge the two maps.
  Map<String, String>? defaultHeaders;

  /// Optional : Define interceptor that will catch HttpResponse.
  InterfaceInterceptor? interceptor;

  /// Classes extending @{AbstractHttpService} have to implement this fromJson method,
  /// to define the serialization of an http response.
  T fromJson(Map<String, dynamic> map);

  set setInterceptor(InterfaceInterceptor? newInterceptor) => interceptor = newInterceptor;

  set setDefaultHeaders(Map<String, String>? newDefaultHeaders) => defaultHeaders = newDefaultHeaders;

  Future<http.Response?> callInterceptor(Future<http.Response?> httpCall) {
    return httpCall.then((httpResponse) {
      interceptor?.catchResponse(httpResponse);
      return httpResponse;
    });
  }

  /// Merge headers passed to method level with the defaultHeaders of the service.
  Map<String, String>? _mergeHeaders(Map<String, String>? headers) {
    return {...?defaultHeaders, ...?headers};
  }

  @override
  Future<dynamic> create(T body,
      {Map<String, String>? headers, Map<String, String>? queryParams, Encoding? encoding, Duration? timeout}) {
    final Duration _timeout = timeout ?? _defaultTimeoutDuration;

    final Uri uri = useHttps
        ? Uri.https(EnvironmentConfig.serverUrl, path, queryParams)
        : Uri.http(EnvironmentConfig.serverUrl, path, queryParams);

    final Map<String, dynamic> bodyJson = body.toJson();

    final String json = jsonEncode(bodyJson);

    final Map<String, String>? headersToSend = _mergeHeaders(headers);

    return callInterceptor(http.post(uri, body: json, headers: headersToSend, encoding: encoding))
        .timeout(_timeout, onTimeout: () => _defaultTimeoutResponse)
        .then((value) {
      // Status between 200 and 300
      if (value!.statusCode >= HttpStatus.ok && value.statusCode < HttpStatus.multipleChoices) {
        return value.body;
      } else {
        return Future.error(value.body);
      }
    });
  }

  @override
  Future<void> update(T body, {Map<String, String>? headers, Map<String, String>? queryParams, Encoding? encoding}) {
    final String id = body.id.toString();
    final Uri uri = useHttps
        ? Uri.https(EnvironmentConfig.serverUrl, '$path/$id', queryParams)
        : Uri.http(EnvironmentConfig.serverUrl, '$path/$id', queryParams);
    final Map<String, dynamic> bodyJson = body.toJson();
    final String json = jsonEncode(bodyJson);
    final Map<String, String>? headersToSend = _mergeHeaders(headers);

    return callInterceptor(http.put(uri, body: json, headers: headersToSend, encoding: encoding));
  }

  @override
  Future<void> delete(U id, {Map<String, String>? headers, Map<String, String>? queryParams, Encoding? encoding}) {
    final Uri uri = useHttps
        ? Uri.https(EnvironmentConfig.serverUrl, '$path/$id', queryParams)
        : Uri.http(EnvironmentConfig.serverUrl, '$path/$id', queryParams);
    final Map<String, String>? headersToSend = _mergeHeaders(headers);
    return callInterceptor(http.delete(uri, headers: headersToSend, encoding: encoding));
  }

  @override
  Future<T> read(U id, {Map<String, String>? headers, Map<String, String>? queryParams, List<String>? jsonRoot}) {
    final Uri uri = useHttps
        ? Uri.https(EnvironmentConfig.serverUrl, '$path/$id', queryParams)
        : Uri.http(EnvironmentConfig.serverUrl, '$path/$id', queryParams);
    final Map<String, String>? headersToSend = {...?headers, ...?defaultHeaders};
    return callInterceptor(http.get(uri, headers: headersToSend)).then((response) {
      if (response != null &&
          response.statusCode >= HttpStatus.ok &&
          response.statusCode < HttpStatus.multipleChoices) {
        var body = _decodeResponseBodyWithJsonPath(response, jsonRoot);

        return fromJson(body);
      }
      throw Exception('ERROR while reading domain.');
    });
  }

  /// Method that will make a Http GET to the
  @override
  Future<List<T>> getAll({Map<String, String>? headers, Map<String, String>? queryParams, List<String>? jsonRoot}) {
    final Uri uri = useHttps
        ? Uri.https(EnvironmentConfig.serverUrl, path, queryParams)
        : Uri.http(EnvironmentConfig.serverUrl, path, queryParams);
    final Map<String, String>? headersToSend = {...?headers, ...?defaultHeaders};
    return callInterceptor(http.get(uri, headers: headersToSend)).then((response) {
      if (response != null &&
          response.statusCode >= HttpStatus.ok &&
          response.statusCode < HttpStatus.multipleChoices) {
        final List<dynamic> listMap = _decodeResponseBodyWithJsonPath(response, jsonRoot);
        return listMap.map((e) => fromJson(e)).toList();
      }
      throw Exception('ERROR while reading all domains.');
    });
  }

  _decodeResponseBodyWithJsonPath(http.Response response, List<String>? jsonRoot) {
    dynamic body = jsonDecode(response.body);
    if (jsonRoot != null && jsonRoot.isNotEmpty) {
      for (String jsonPath in jsonRoot) {
        body = body[jsonPath];
      }
    }
    return body;
  }
}
