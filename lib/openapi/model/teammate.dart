//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Teammate {
  /// Returns a new [Teammate] instance.
  Teammate({
    this.id,
    this.nom,
    this.prenom,
    this.dateNaissance,
    this.photoUrl,
    this.email,
    this.telephone,
    this.description,
    this.listDocument = const {},
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
  DateTime? dateNaissance;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? photoUrl;

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

  Set<Document> listDocument;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Teammate &&
     other.id == id &&
     other.nom == nom &&
     other.prenom == prenom &&
     other.dateNaissance == dateNaissance &&
     other.photoUrl == photoUrl &&
     other.email == email &&
     other.telephone == telephone &&
     other.description == description &&
     other.listDocument == listDocument;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (nom == null ? 0 : nom!.hashCode) +
    (prenom == null ? 0 : prenom!.hashCode) +
    (dateNaissance == null ? 0 : dateNaissance!.hashCode) +
    (photoUrl == null ? 0 : photoUrl!.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (telephone == null ? 0 : telephone!.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (listDocument.hashCode);

  @override
  String toString() => 'Teammate[id=$id, nom=$nom, prenom=$prenom, dateNaissance=$dateNaissance, photoUrl=$photoUrl, email=$email, telephone=$telephone, description=$description, listDocument=$listDocument]';

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
      _json[r'dateNaissance'] = dateNaissance!.toUtc().toIso8601String();
    }
    if (photoUrl != null) {
      _json[r'photoUrl'] = photoUrl;
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
      _json[r'listDocument'] = listDocument;
    return _json;
  }

  /// Returns a new [Teammate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Teammate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Teammate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Teammate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Teammate(
        id: mapValueOfType<int>(json, r'id'),
        nom: mapValueOfType<String>(json, r'nom'),
        prenom: mapValueOfType<String>(json, r'prenom'),
        dateNaissance: mapDateTime(json, r'dateNaissance', ''),
        photoUrl: mapValueOfType<String>(json, r'photoUrl'),
        email: mapValueOfType<String>(json, r'email'),
        telephone: mapValueOfType<String>(json, r'telephone'),
        description: mapValueOfType<String>(json, r'description'),
        listDocument: Document.listFromJson(json[r'listDocument']) ?? const {},
      );
    }
    return null;
  }

  static List<Teammate>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Teammate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Teammate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Teammate> mapFromJson(dynamic json) {
    final map = <String, Teammate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Teammate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Teammate-objects as value to a dart map
  static Map<String, List<Teammate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Teammate>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Teammate.listFromJson(entry.value, growable: growable,);
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

