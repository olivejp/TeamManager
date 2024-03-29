//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Competence {
  /// Returns a new [Competence] instance.
  Competence({
    required this.nom,
    this.id,
  });

  String nom;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Competence &&
     other.nom == nom &&
     other.id == id;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (nom.hashCode) +
    (id == null ? 0 : id!.hashCode);

  @override
  String toString() => 'Competence[nom=$nom, id=$id]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'nom'] = nom;
    if (id != null) {
      _json[r'id'] = id;
    }
    return _json;
  }

  /// Returns a new [Competence] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Competence? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Competence[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Competence[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Competence(
        nom: mapValueOfType<String>(json, r'nom')!,
        id: mapValueOfType<int>(json, r'id'),
      );
    }
    return null;
  }

  static List<Competence>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Competence>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Competence.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Competence> mapFromJson(dynamic json) {
    final map = <String, Competence>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Competence.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Competence-objects as value to a dart map
  static Map<String, List<Competence>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Competence>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Competence.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'nom',
  };
}

