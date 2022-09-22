//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/alive_controller_api.dart';
part 'api/competence_controller_api.dart';
part 'api/conges_controller_api.dart';
part 'api/customer_controller_api.dart';
part 'api/document_controller_api.dart';
part 'api/planning_controller_api.dart';
part 'api/teammate_controller_api.dart';

part 'model/appointment.dart';
part 'model/competence.dart';
part 'model/conges_create_dto.dart';
part 'model/conges_dto.dart';
part 'model/contraints_validation_error.dart';
part 'model/customer_dto.dart';
part 'model/document.dart';
part 'model/page_competence.dart';
part 'model/page_conges_dto.dart';
part 'model/page_customer_dto.dart';
part 'model/page_teammate_dto.dart';
part 'model/pageable.dart';
part 'model/pageable_object.dart';
part 'model/sort_object.dart';
part 'model/teammate_dto.dart';


const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

ApiClient defaultApiClient = ApiClient();
