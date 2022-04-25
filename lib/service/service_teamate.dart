import 'dart:io';

import '../domain/teamate.dart';
import 'abstract_http_service.dart';
import 'interface_interceptor.dart';

class ServiceTeamate extends AbstractHttpService<Teamate, int> {
  ServiceTeamate({InterfaceInterceptor? interceptor, Map<String, String>? Function()? getHeaders})
      : super(path: '/api/teamate', interceptor: interceptor, getHeaders: getHeaders, defaultHeaders: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });

  @override
  Teamate fromJson(Map<String, dynamic> map) {
    return Teamate.fromJson(map);
  }
}
