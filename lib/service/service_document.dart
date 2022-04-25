import 'dart:io';

import 'package:team_manager/domain/document.dart';

import 'abstract_http_service.dart';
import 'interface_interceptor.dart';

class DocumentService extends AbstractHttpService<Document, int> {
  DocumentService({InterfaceInterceptor? interceptor, Map<String, String>? Function()? getHeaders})
      : super(
            path: '/document',
            interceptor: interceptor,
            getHeaders: getHeaders,
            defaultHeaders: {HttpHeaders.contentTypeHeader: 'application/json'});

  @override
  Document fromJson(Map<String, dynamic> map) {
    return Document.fromJson(map);
  }
}
