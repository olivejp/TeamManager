import 'dart:io';

import 'package:team_manager/domain/document.dart';

import 'abstract_http_service.dart';
import 'interface_interceptor.dart';

class DocumentService extends AbstractHttpService<Document, int> {
  DocumentService({InterfaceInterceptor? interceptor})
      : super(
            path: '/document',
            interceptor: interceptor,
            defaultHeaders: {HttpHeaders.contentTypeHeader: 'application/json'});

  @override
  Document fromJson(Map<String, dynamic> map) {
    return Document.fromJson(map);
  }
}
