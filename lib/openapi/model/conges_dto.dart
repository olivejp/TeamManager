//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CongesDto {
  /// Returns a new [CongesDto] instance.
  CongesDto({
    this.id,
    this.teammate,
    this.dateDebut,
    this.dateFin,
    this.typeConges,
    this.portionDebut,
    this.portionFin,
    this.commentaire,
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
  TeammateDto? teammate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? dateDebut;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? dateFin;

  CongesDtoTypeCongesEnum? typeConges;

  CongesDtoPortionDebutEnum? portionDebut;

  CongesDtoPortionFinEnum? portionFin;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? commentaire;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CongesDto &&
     other.id == id &&
     other.teammate == teammate &&
     other.dateDebut == dateDebut &&
     other.dateFin == dateFin &&
     other.typeConges == typeConges &&
     other.portionDebut == portionDebut &&
     other.portionFin == portionFin &&
     other.commentaire == commentaire;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (teammate == null ? 0 : teammate!.hashCode) +
    (dateDebut == null ? 0 : dateDebut!.hashCode) +
    (dateFin == null ? 0 : dateFin!.hashCode) +
    (typeConges == null ? 0 : typeConges!.hashCode) +
    (portionDebut == null ? 0 : portionDebut!.hashCode) +
    (portionFin == null ? 0 : portionFin!.hashCode) +
    (commentaire == null ? 0 : commentaire!.hashCode);

  @override
  String toString() => 'CongesDto[id=$id, teammate=$teammate, dateDebut=$dateDebut, dateFin=$dateFin, typeConges=$typeConges, portionDebut=$portionDebut, portionFin=$portionFin, commentaire=$commentaire]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    if (id != null) {
      _json[r'id'] = id;
    }
    if (teammate != null) {
      _json[r'teammate'] = teammate;
    }
    if (dateDebut != null) {
      _json[r'dateDebut'] = dateDebut!.toUtc().toIso8601String();
    }
    if (dateFin != null) {
      _json[r'dateFin'] = dateFin!.toUtc().toIso8601String();
    }
    if (typeConges != null) {
      _json[r'typeConges'] = typeConges;
    }
    if (portionDebut != null) {
      _json[r'portionDebut'] = portionDebut;
    }
    if (portionFin != null) {
      _json[r'portionFin'] = portionFin;
    }
    if (commentaire != null) {
      _json[r'commentaire'] = commentaire;
    }
    return _json;
  }

  /// Returns a new [CongesDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CongesDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CongesDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CongesDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CongesDto(
        id: mapValueOfType<int>(json, r'id'),
        teammate: TeammateDto.fromJson(json[r'teammate']),
        dateDebut: mapDateTime(json, r'dateDebut', ''),
        dateFin: mapDateTime(json, r'dateFin', ''),
        typeConges: CongesDtoTypeCongesEnum.fromJson(json[r'typeConges']),
        portionDebut: CongesDtoPortionDebutEnum.fromJson(json[r'portionDebut']),
        portionFin: CongesDtoPortionFinEnum.fromJson(json[r'portionFin']),
        commentaire: mapValueOfType<String>(json, r'commentaire'),
      );
    }
    return null;
  }

  static List<CongesDto>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CongesDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CongesDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CongesDto> mapFromJson(dynamic json) {
    final map = <String, CongesDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CongesDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CongesDto-objects as value to a dart map
  static Map<String, List<CongesDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CongesDto>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CongesDto.listFromJson(entry.value, growable: growable,);
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


class CongesDtoTypeCongesEnum {
  /// Instantiate a new enum with the provided [value].
  const CongesDtoTypeCongesEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const CONGE_PAYE = CongesDtoTypeCongesEnum._(r'CONGE_PAYE');
  static const MALADIE = CongesDtoTypeCongesEnum._(r'MALADIE');
  static const SANS_SOLDE = CongesDtoTypeCongesEnum._(r'SANS_SOLDE');

  /// List of all possible values in this [enum][CongesDtoTypeCongesEnum].
  static const values = <CongesDtoTypeCongesEnum>[
    CONGE_PAYE,
    MALADIE,
    SANS_SOLDE,
  ];

  static CongesDtoTypeCongesEnum? fromJson(dynamic value) => CongesDtoTypeCongesEnumTypeTransformer().decode(value);

  static List<CongesDtoTypeCongesEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CongesDtoTypeCongesEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CongesDtoTypeCongesEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CongesDtoTypeCongesEnum] to String,
/// and [decode] dynamic data back to [CongesDtoTypeCongesEnum].
class CongesDtoTypeCongesEnumTypeTransformer {
  factory CongesDtoTypeCongesEnumTypeTransformer() => _instance ??= const CongesDtoTypeCongesEnumTypeTransformer._();

  const CongesDtoTypeCongesEnumTypeTransformer._();

  String encode(CongesDtoTypeCongesEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CongesDtoTypeCongesEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CongesDtoTypeCongesEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data.toString()) {
        case r'CONGE_PAYE': return CongesDtoTypeCongesEnum.CONGE_PAYE;
        case r'MALADIE': return CongesDtoTypeCongesEnum.MALADIE;
        case r'SANS_SOLDE': return CongesDtoTypeCongesEnum.SANS_SOLDE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CongesDtoTypeCongesEnumTypeTransformer] instance.
  static CongesDtoTypeCongesEnumTypeTransformer? _instance;
}



class CongesDtoPortionDebutEnum {
  /// Instantiate a new enum with the provided [value].
  const CongesDtoPortionDebutEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const MATIN = CongesDtoPortionDebutEnum._(r'MATIN');
  static const APRES_MIDI = CongesDtoPortionDebutEnum._(r'APRES_MIDI');

  /// List of all possible values in this [enum][CongesDtoPortionDebutEnum].
  static const values = <CongesDtoPortionDebutEnum>[
    MATIN,
    APRES_MIDI,
  ];

  static CongesDtoPortionDebutEnum? fromJson(dynamic value) => CongesDtoPortionDebutEnumTypeTransformer().decode(value);

  static List<CongesDtoPortionDebutEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CongesDtoPortionDebutEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CongesDtoPortionDebutEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CongesDtoPortionDebutEnum] to String,
/// and [decode] dynamic data back to [CongesDtoPortionDebutEnum].
class CongesDtoPortionDebutEnumTypeTransformer {
  factory CongesDtoPortionDebutEnumTypeTransformer() => _instance ??= const CongesDtoPortionDebutEnumTypeTransformer._();

  const CongesDtoPortionDebutEnumTypeTransformer._();

  String encode(CongesDtoPortionDebutEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CongesDtoPortionDebutEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CongesDtoPortionDebutEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data.toString()) {
        case r'MATIN': return CongesDtoPortionDebutEnum.MATIN;
        case r'APRES_MIDI': return CongesDtoPortionDebutEnum.APRES_MIDI;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CongesDtoPortionDebutEnumTypeTransformer] instance.
  static CongesDtoPortionDebutEnumTypeTransformer? _instance;
}



class CongesDtoPortionFinEnum {
  /// Instantiate a new enum with the provided [value].
  const CongesDtoPortionFinEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const MATIN = CongesDtoPortionFinEnum._(r'MATIN');
  static const APRES_MIDI = CongesDtoPortionFinEnum._(r'APRES_MIDI');

  /// List of all possible values in this [enum][CongesDtoPortionFinEnum].
  static const values = <CongesDtoPortionFinEnum>[
    MATIN,
    APRES_MIDI,
  ];

  static CongesDtoPortionFinEnum? fromJson(dynamic value) => CongesDtoPortionFinEnumTypeTransformer().decode(value);

  static List<CongesDtoPortionFinEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CongesDtoPortionFinEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CongesDtoPortionFinEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CongesDtoPortionFinEnum] to String,
/// and [decode] dynamic data back to [CongesDtoPortionFinEnum].
class CongesDtoPortionFinEnumTypeTransformer {
  factory CongesDtoPortionFinEnumTypeTransformer() => _instance ??= const CongesDtoPortionFinEnumTypeTransformer._();

  const CongesDtoPortionFinEnumTypeTransformer._();

  String encode(CongesDtoPortionFinEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CongesDtoPortionFinEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CongesDtoPortionFinEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data.toString()) {
        case r'MATIN': return CongesDtoPortionFinEnum.MATIN;
        case r'APRES_MIDI': return CongesDtoPortionFinEnum.APRES_MIDI;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CongesDtoPortionFinEnumTypeTransformer] instance.
  static CongesDtoPortionFinEnumTypeTransformer? _instance;
}


