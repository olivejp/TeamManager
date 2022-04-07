import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:team_manager/service/interface_interceptor.dart';

class HttpInterceptor implements InterfaceInterceptor {
  @override
  Future<Object?> catchResponse(http.Response? response) {
    if (response?.statusCode == 400 && response?.body != null) {
      final dynamic body = jsonDecode(utf8.decode(response!.bodyBytes));
      final String? type = body['type'];
      if (type != null && type == 'ContraintsValidationError') {
        final String? errors = body['error'];
        return Future.error(errors!);
      }
    }
    return Future.value("");
  }
}
