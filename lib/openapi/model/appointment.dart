//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Appointment {
  /// Returns a new [Appointment] instance.
  Appointment({
    this.dateTimeBegin,
    this.dateTimeEnd,
    this.rendezVous,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? dateTimeBegin;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? dateTimeEnd;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? rendezVous;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Appointment &&
     other.dateTimeBegin == dateTimeBegin &&
     other.dateTimeEnd == dateTimeEnd &&
     other.rendezVous == rendezVous;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (dateTimeBegin == null ? 0 : dateTimeBegin!.hashCode) +
    (dateTimeEnd == null ? 0 : dateTimeEnd!.hashCode) +
    (rendezVous == null ? 0 : rendezVous!.hashCode);

  @override
  String toString() => 'Appointment[dateTimeBegin=$dateTimeBegin, dateTimeEnd=$dateTimeEnd, rendezVous=$rendezVous]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    if (dateTimeBegin != null) {
      _json[r'dateTimeBegin'] = dateTimeBegin!.toUtc().toIso8601String();
    }
    if (dateTimeEnd != null) {
      _json[r'dateTimeEnd'] = dateTimeEnd!.toUtc().toIso8601String();
    }
    if (rendezVous != null) {
      _json[r'rendezVous'] = rendezVous;
    }
    return _json;
  }

  /// Returns a new [Appointment] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Appointment? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Appointment[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Appointment[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Appointment(
        dateTimeBegin: mapDateTime(json, r'dateTimeBegin', ''),
        dateTimeEnd: mapDateTime(json, r'dateTimeEnd', ''),
        rendezVous: mapValueOfType<String>(json, r'rendezVous'),
      );
    }
    return null;
  }

  static List<Appointment>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Appointment>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Appointment.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Appointment> mapFromJson(dynamic json) {
    final map = <String, Appointment>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Appointment.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Appointment-objects as value to a dart map
  static Map<String, List<Appointment>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Appointment>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Appointment.listFromJson(entry.value, growable: growable,);
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

