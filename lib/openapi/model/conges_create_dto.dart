//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CongesCreateDto {
  /// Returns a new [CongesCreateDto] instance.
  CongesCreateDto({
    required this.teammateId,
    required this.dateDebut,
    required this.dateFin,
    required this.portionDebut,
    required this.portionFin,
    required this.typeConges,
    this.commentaire,
  });

  int teammateId;

  DateTime dateDebut;

  DateTime dateFin;

  CongesCreateDtoPortionDebutEnum portionDebut;

  CongesCreateDtoPortionFinEnum portionFin;

  CongesCreateDtoTypeCongesEnum typeConges;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? commentaire;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CongesCreateDto &&
     other.teammateId == teammateId &&
     other.dateDebut == dateDebut &&
     other.dateFin == dateFin &&
     other.portionDebut == portionDebut &&
     other.portionFin == portionFin &&
     other.typeConges == typeConges &&
     other.commentaire == commentaire;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (teammateId.hashCode) +
    (dateDebut.hashCode) +
    (dateFin.hashCode) +
    (portionDebut.hashCode) +
    (portionFin.hashCode) +
    (typeConges.hashCode) +
    (commentaire == null ? 0 : commentaire!.hashCode);

  @override
  String toString() => 'CongesCreateDto[teammateId=$teammateId, dateDebut=$dateDebut, dateFin=$dateFin, portionDebut=$portionDebut, portionFin=$portionFin, typeConges=$typeConges, commentaire=$commentaire]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'teammateId'] = teammateId;
      _json[r'dateDebut'] = dateDebut.toUtc().toIso8601String();
      _json[r'dateFin'] = dateFin.toUtc().toIso8601String();
      _json[r'portionDebut'] = portionDebut;
      _json[r'portionFin'] = portionFin;
      _json[r'typeConges'] = typeConges;
    if (commentaire != null) {
      _json[r'commentaire'] = commentaire;
    }
    return _json;
  }

  /// Returns a new [CongesCreateDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CongesCreateDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CongesCreateDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CongesCreateDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CongesCreateDto(
        teammateId: mapValueOfType<int>(json, r'teammateId')!,
        dateDebut: mapDateTime(json, r'dateDebut', '')!,
        dateFin: mapDateTime(json, r'dateFin', '')!,
        portionDebut: CongesCreateDtoPortionDebutEnum.fromJson(json[r'portionDebut'])!,
        portionFin: CongesCreateDtoPortionFinEnum.fromJson(json[r'portionFin'])!,
        typeConges: CongesCreateDtoTypeCongesEnum.fromJson(json[r'typeConges'])!,
        commentaire: mapValueOfType<String>(json, r'commentaire'),
      );
    }
    return null;
  }

  static List<CongesCreateDto>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CongesCreateDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CongesCreateDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CongesCreateDto> mapFromJson(dynamic json) {
    final map = <String, CongesCreateDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CongesCreateDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CongesCreateDto-objects as value to a dart map
  static Map<String, List<CongesCreateDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CongesCreateDto>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CongesCreateDto.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'teammateId',
    'dateDebut',
    'dateFin',
    'portionDebut',
    'portionFin',
    'typeConges',
  };
}


class CongesCreateDtoPortionDebutEnum {
  /// Instantiate a new enum with the provided [value].
  const CongesCreateDtoPortionDebutEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const MATIN = CongesCreateDtoPortionDebutEnum._(r'MATIN');
  static const APRES_MIDI = CongesCreateDtoPortionDebutEnum._(r'APRES_MIDI');

  /// List of all possible values in this [enum][CongesCreateDtoPortionDebutEnum].
  static const values = <CongesCreateDtoPortionDebutEnum>[
    MATIN,
    APRES_MIDI,
  ];

  static CongesCreateDtoPortionDebutEnum? fromJson(dynamic value) => CongesCreateDtoPortionDebutEnumTypeTransformer().decode(value);

  static List<CongesCreateDtoPortionDebutEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CongesCreateDtoPortionDebutEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CongesCreateDtoPortionDebutEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CongesCreateDtoPortionDebutEnum] to String,
/// and [decode] dynamic data back to [CongesCreateDtoPortionDebutEnum].
class CongesCreateDtoPortionDebutEnumTypeTransformer {
  factory CongesCreateDtoPortionDebutEnumTypeTransformer() => _instance ??= const CongesCreateDtoPortionDebutEnumTypeTransformer._();

  const CongesCreateDtoPortionDebutEnumTypeTransformer._();

  String encode(CongesCreateDtoPortionDebutEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CongesCreateDtoPortionDebutEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CongesCreateDtoPortionDebutEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data.toString()) {
        case r'MATIN': return CongesCreateDtoPortionDebutEnum.MATIN;
        case r'APRES_MIDI': return CongesCreateDtoPortionDebutEnum.APRES_MIDI;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CongesCreateDtoPortionDebutEnumTypeTransformer] instance.
  static CongesCreateDtoPortionDebutEnumTypeTransformer? _instance;
}



class CongesCreateDtoPortionFinEnum {
  /// Instantiate a new enum with the provided [value].
  const CongesCreateDtoPortionFinEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const MATIN = CongesCreateDtoPortionFinEnum._(r'MATIN');
  static const APRES_MIDI = CongesCreateDtoPortionFinEnum._(r'APRES_MIDI');

  /// List of all possible values in this [enum][CongesCreateDtoPortionFinEnum].
  static const values = <CongesCreateDtoPortionFinEnum>[
    MATIN,
    APRES_MIDI,
  ];

  static CongesCreateDtoPortionFinEnum? fromJson(dynamic value) => CongesCreateDtoPortionFinEnumTypeTransformer().decode(value);

  static List<CongesCreateDtoPortionFinEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CongesCreateDtoPortionFinEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CongesCreateDtoPortionFinEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CongesCreateDtoPortionFinEnum] to String,
/// and [decode] dynamic data back to [CongesCreateDtoPortionFinEnum].
class CongesCreateDtoPortionFinEnumTypeTransformer {
  factory CongesCreateDtoPortionFinEnumTypeTransformer() => _instance ??= const CongesCreateDtoPortionFinEnumTypeTransformer._();

  const CongesCreateDtoPortionFinEnumTypeTransformer._();

  String encode(CongesCreateDtoPortionFinEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CongesCreateDtoPortionFinEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CongesCreateDtoPortionFinEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data.toString()) {
        case r'MATIN': return CongesCreateDtoPortionFinEnum.MATIN;
        case r'APRES_MIDI': return CongesCreateDtoPortionFinEnum.APRES_MIDI;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CongesCreateDtoPortionFinEnumTypeTransformer] instance.
  static CongesCreateDtoPortionFinEnumTypeTransformer? _instance;
}



class CongesCreateDtoTypeCongesEnum {
  /// Instantiate a new enum with the provided [value].
  const CongesCreateDtoTypeCongesEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const CONGE_PAYE = CongesCreateDtoTypeCongesEnum._(r'CONGE_PAYE');
  static const MALADIE = CongesCreateDtoTypeCongesEnum._(r'MALADIE');
  static const SANS_SOLDE = CongesCreateDtoTypeCongesEnum._(r'SANS_SOLDE');

  /// List of all possible values in this [enum][CongesCreateDtoTypeCongesEnum].
  static const values = <CongesCreateDtoTypeCongesEnum>[
    CONGE_PAYE,
    MALADIE,
    SANS_SOLDE,
  ];

  static CongesCreateDtoTypeCongesEnum? fromJson(dynamic value) => CongesCreateDtoTypeCongesEnumTypeTransformer().decode(value);

  static List<CongesCreateDtoTypeCongesEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CongesCreateDtoTypeCongesEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CongesCreateDtoTypeCongesEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CongesCreateDtoTypeCongesEnum] to String,
/// and [decode] dynamic data back to [CongesCreateDtoTypeCongesEnum].
class CongesCreateDtoTypeCongesEnumTypeTransformer {
  factory CongesCreateDtoTypeCongesEnumTypeTransformer() => _instance ??= const CongesCreateDtoTypeCongesEnumTypeTransformer._();

  const CongesCreateDtoTypeCongesEnumTypeTransformer._();

  String encode(CongesCreateDtoTypeCongesEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CongesCreateDtoTypeCongesEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CongesCreateDtoTypeCongesEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data.toString()) {
        case r'CONGE_PAYE': return CongesCreateDtoTypeCongesEnum.CONGE_PAYE;
        case r'MALADIE': return CongesCreateDtoTypeCongesEnum.MALADIE;
        case r'SANS_SOLDE': return CongesCreateDtoTypeCongesEnum.SANS_SOLDE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CongesCreateDtoTypeCongesEnumTypeTransformer] instance.
  static CongesCreateDtoTypeCongesEnumTypeTransformer? _instance;
}


