//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CustomerDto {
  /// Returns a new [CustomerDto] instance.
  CustomerDto({
    this.id,
    this.ridet,
    this.raisonSociale,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? ridet;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? raisonSociale;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CustomerDto &&
     other.id == id &&
     other.ridet == ridet &&
     other.raisonSociale == raisonSociale;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (ridet == null ? 0 : ridet!.hashCode) +
    (raisonSociale == null ? 0 : raisonSociale!.hashCode);

  @override
  String toString() => 'CustomerDto[id=$id, ridet=$ridet, raisonSociale=$raisonSociale]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    if (id != null) {
      _json[r'id'] = id;
    }
    if (ridet != null) {
      _json[r'ridet'] = ridet;
    }
    if (raisonSociale != null) {
      _json[r'raisonSociale'] = raisonSociale;
    }
    return _json;
  }

  /// Returns a new [CustomerDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CustomerDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CustomerDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CustomerDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CustomerDto(
        id: mapValueOfType<int>(json, r'id'),
        ridet: mapValueOfType<String>(json, r'ridet'),
        raisonSociale: mapValueOfType<String>(json, r'raisonSociale'),
      );
    }
    return null;
  }

  static List<CustomerDto>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CustomerDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CustomerDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CustomerDto> mapFromJson(dynamic json) {
    final map = <String, CustomerDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CustomerDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CustomerDto-objects as value to a dart map
  static Map<String, List<CustomerDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CustomerDto>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CustomerDto.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

