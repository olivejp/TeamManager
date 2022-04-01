import 'dart:io';

import 'package:team_manager/domain/competence.dart';

import 'abstract_http_service.dart';
import 'interface_interceptor.dart';

class CompetenceService extends AbstractHttpService<Competence, int> {
  CompetenceService({InterfaceInterceptor? interceptor})
      : super(
            path: '/competence',
            interceptor: interceptor,
            defaultHeaders: {HttpHeaders.contentTypeHeader: 'application/json'});

  @override
  Competence fromJson(Map<String, dynamic> map) {
    return Competence.fromJson(map);
  }
}