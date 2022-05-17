import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:team_manager/domain/document.dart';
import 'package:team_manager/environment_config.dart';

import 'abstract_http_service.dart';
import 'interface_interceptor.dart';

class DocumentService extends AbstractHttpService<Document, int> {
  DocumentService(
      {InterfaceInterceptor? interceptor,
      Map<String, String>? Function()? getHeaders})
      : super(
            path: '/api/document',
            interceptor: interceptor,
            getHeaders: getHeaders,
            defaultHeaders: {
              HttpHeaders.contentTypeHeader: 'application/json'
            });

  @override
  Document fromJson(Map<String, dynamic> map) {
    return Document.fromJson(map);
  }

  //
  // TODO tester ce nouvel appel
  // qui permet d'uploader le document vers le backend.
  //
  Future<http.StreamedResponse> postDocument(
      {required String name, required Uint8List data}) {
    final Uri uri = useHttps
        ? Uri.https(EnvironmentConfig.serverUrl, path)
        : Uri.http(EnvironmentConfig.serverUrl, path);

    var request = http.MultipartRequest("POST", uri)
    ..fields['name'] = name
    ..files.add(http.MultipartFile.fromBytes('document', data.toList(), filename: name));
    return request.send();
  }
}
