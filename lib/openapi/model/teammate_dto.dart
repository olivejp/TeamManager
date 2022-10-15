//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TeammateDto {
  /// Returns a new [TeammateDto] instance.
  TeammateDto({
    this.id,
    this.nom,
    this.prenom,
    this.dateNaissance,
    this.photo,
    this.email,
    this.telephone,
    this.description,
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
  String? nom;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? prenom;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? dateNaissance;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? photo;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? email;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? telephone;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? description;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TeammateDto &&
     other.id == id &&
     other.nom == nom &&
     other.prenom == prenom &&
     other.dateNaissance == dateNaissance &&
     other.photo == photo &&
     other.email == email &&
     other.telephone == telephone &&
     other.description == description;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (nom == null ? 0 : nom!.hashCode) +
    (prenom == null ? 0 : prenom!.hashCode) +
    (dateNaissance == null ? 0 : dateNaissance!.hashCode) +
    (photo == null ? 0 : photo!.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (telephone == null ? 0 : telephone!.hashCode) +
    (description == null ? 0 : description!.hashCode);

  @override
  String toString() => 'TeammateDto[id=$id, nom=$nom, prenom=$prenom, dateNaissance=$dateNaissance, photo=$photo, email=$email, telephone=$telephone, description=$description]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    if (id != null) {
      _json[r'id'] = id;
    }
    if (nom != null) {
      _json[r'nom'] = nom;
    }
    if (prenom != null) {
      _json[r'prenom'] = prenom;
    }
    if (dateNaissance != null) {
      _json[r'dateNaissance'] = dateNaissance;
    }
    if (photo != null) {
      _json[r'photo'] = photo;
    }
    if (email != null) {
      _json[r'email'] = email;
    }
    if (telephone != null) {
      _json[r'telephone'] = telephone;
    }
    if (description != null) {
      _json[r'description'] = description;
    }
    return _json;
  }

  /// Returns a new [TeammateDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TeammateDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TeammateDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TeammateDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TeammateDto(
        id: mapValueOfType<int>(json, r'id'),
        nom: mapValueOfType<String>(json, r'nom'),
        prenom: mapValueOfType<String>(json, r'prenom'),
        dateNaissance: mapValueOfType<String>(json, r'dateNaissance'),
        photo: mapValueOfType<String>(json, r'photo'),
        email: mapValueOfType<String>(json, r'email'),
        telephone: mapValueOfType<String>(json, r'telephone'),
        description: mapValueOfType<String>(json, r'description'),
      );
    }
    return null;
  }

  static List<TeammateDto>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TeammateDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TeammateDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TeammateDto> mapFromJson(dynamic json) {
    final map = <String, TeammateDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TeammateDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TeammateDto-objects as value to a dart map
  static Map<String, List<TeammateDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TeammateDto>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TeammateDto.listFromJson(entry.value, growable: growable,);
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

