//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CongesPersistDto {
  /// Returns a new [CongesPersistDto] instance.
  CongesPersistDto({
    required this.teammateId,
    required this.dateDebut,
    required this.dateFin,
    required this.portionDebut,
    required this.portionFin,
    required this.typeConges,
    this.id,
    this.commentaire,
  });

  int teammateId;

  String dateDebut;

  String dateFin;

  CongesPersistDtoPortionDebutEnum portionDebut;

  CongesPersistDtoPortionFinEnum portionFin;

  CongesPersistDtoTypeCongesEnum typeConges;

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
  String? commentaire;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CongesPersistDto &&
     other.teammateId == teammateId &&
     other.dateDebut == dateDebut &&
     other.dateFin == dateFin &&
     other.portionDebut == portionDebut &&
     other.portionFin == portionFin &&
     other.typeConges == typeConges &&
     other.id == id &&
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
    (id == null ? 0 : id!.hashCode) +
    (commentaire == null ? 0 : commentaire!.hashCode);

  @override
  String toString() => 'CongesPersistDto[teammateId=$teammateId, dateDebut=$dateDebut, dateFin=$dateFin, portionDebut=$portionDebut, portionFin=$portionFin, typeConges=$typeConges, id=$id, commentaire=$commentaire]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'teammateId'] = teammateId;
      _json[r'dateDebut'] = dateDebut;
      _json[r'dateFin'] = dateFin;
      _json[r'portionDebut'] = portionDebut;
      _json[r'portionFin'] = portionFin;
      _json[r'typeConges'] = typeConges;
    if (id != null) {
      _json[r'id'] = id;
    }
    if (commentaire != null) {
      _json[r'commentaire'] = commentaire;
    }
    return _json;
  }

  /// Returns a new [CongesPersistDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CongesPersistDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CongesPersistDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CongesPersistDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CongesPersistDto(
        teammateId: mapValueOfType<int>(json, r'teammateId')!,
        dateDebut: mapValueOfType<String>(json, r'dateDebut')!,
        dateFin: mapValueOfType<String>(json, r'dateFin')!,
        portionDebut: CongesPersistDtoPortionDebutEnum.fromJson(json[r'portionDebut'])!,
        portionFin: CongesPersistDtoPortionFinEnum.fromJson(json[r'portionFin'])!,
        typeConges: CongesPersistDtoTypeCongesEnum.fromJson(json[r'typeConges'])!,
        id: mapValueOfType<int>(json, r'id'),
        commentaire: mapValueOfType<String>(json, r'commentaire'),
      );
    }
    return null;
  }

  static List<CongesPersistDto>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CongesPersistDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CongesPersistDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CongesPersistDto> mapFromJson(dynamic json) {
    final map = <String, CongesPersistDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CongesPersistDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CongesPersistDto-objects as value to a dart map
  static Map<String, List<CongesPersistDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CongesPersistDto>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CongesPersistDto.listFromJson(entry.value, growable: growable,);
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


class CongesPersistDtoPortionDebutEnum {
  /// Instantiate a new enum with the provided [value].
  const CongesPersistDtoPortionDebutEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const MATIN = CongesPersistDtoPortionDebutEnum._(r'MATIN');
  static const APRES_MIDI = CongesPersistDtoPortionDebutEnum._(r'APRES_MIDI');

  /// List of all possible values in this [enum][CongesPersistDtoPortionDebutEnum].
  static const values = <CongesPersistDtoPortionDebutEnum>[
    MATIN,
    APRES_MIDI,
  ];

  static CongesPersistDtoPortionDebutEnum? fromJson(dynamic value) => CongesPersistDtoPortionDebutEnumTypeTransformer().decode(value);

  static List<CongesPersistDtoPortionDebutEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CongesPersistDtoPortionDebutEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CongesPersistDtoPortionDebutEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CongesPersistDtoPortionDebutEnum] to String,
/// and [decode] dynamic data back to [CongesPersistDtoPortionDebutEnum].
class CongesPersistDtoPortionDebutEnumTypeTransformer {
  factory CongesPersistDtoPortionDebutEnumTypeTransformer() => _instance ??= const CongesPersistDtoPortionDebutEnumTypeTransformer._();

  const CongesPersistDtoPortionDebutEnumTypeTransformer._();

  String encode(CongesPersistDtoPortionDebutEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CongesPersistDtoPortionDebutEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CongesPersistDtoPortionDebutEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data.toString()) {
        case r'MATIN': return CongesPersistDtoPortionDebutEnum.MATIN;
        case r'APRES_MIDI': return CongesPersistDtoPortionDebutEnum.APRES_MIDI;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CongesPersistDtoPortionDebutEnumTypeTransformer] instance.
  static CongesPersistDtoPortionDebutEnumTypeTransformer? _instance;
}



class CongesPersistDtoPortionFinEnum {
  /// Instantiate a new enum with the provided [value].
  const CongesPersistDtoPortionFinEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const MATIN = CongesPersistDtoPortionFinEnum._(r'MATIN');
  static const APRES_MIDI = CongesPersistDtoPortionFinEnum._(r'APRES_MIDI');

  /// List of all possible values in this [enum][CongesPersistDtoPortionFinEnum].
  static const values = <CongesPersistDtoPortionFinEnum>[
    MATIN,
    APRES_MIDI,
  ];

  static CongesPersistDtoPortionFinEnum? fromJson(dynamic value) => CongesPersistDtoPortionFinEnumTypeTransformer().decode(value);

  static List<CongesPersistDtoPortionFinEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CongesPersistDtoPortionFinEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CongesPersistDtoPortionFinEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CongesPersistDtoPortionFinEnum] to String,
/// and [decode] dynamic data back to [CongesPersistDtoPortionFinEnum].
class CongesPersistDtoPortionFinEnumTypeTransformer {
  factory CongesPersistDtoPortionFinEnumTypeTransformer() => _instance ??= const CongesPersistDtoPortionFinEnumTypeTransformer._();

  const CongesPersistDtoPortionFinEnumTypeTransformer._();

  String encode(CongesPersistDtoPortionFinEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CongesPersistDtoPortionFinEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CongesPersistDtoPortionFinEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data.toString()) {
        case r'MATIN': return CongesPersistDtoPortionFinEnum.MATIN;
        case r'APRES_MIDI': return CongesPersistDtoPortionFinEnum.APRES_MIDI;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CongesPersistDtoPortionFinEnumTypeTransformer] instance.
  static CongesPersistDtoPortionFinEnumTypeTransformer? _instance;
}



class CongesPersistDtoTypeCongesEnum {
  /// Instantiate a new enum with the provided [value].
  const CongesPersistDtoTypeCongesEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const CONGE_PAYE = CongesPersistDtoTypeCongesEnum._(r'CONGE_PAYE');
  static const MALADIE = CongesPersistDtoTypeCongesEnum._(r'MALADIE');
  static const SANS_SOLDE = CongesPersistDtoTypeCongesEnum._(r'SANS_SOLDE');

  /// List of all possible values in this [enum][CongesPersistDtoTypeCongesEnum].
  static const values = <CongesPersistDtoTypeCongesEnum>[
    CONGE_PAYE,
    MALADIE,
    SANS_SOLDE,
  ];

  static CongesPersistDtoTypeCongesEnum? fromJson(dynamic value) => CongesPersistDtoTypeCongesEnumTypeTransformer().decode(value);

  static List<CongesPersistDtoTypeCongesEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CongesPersistDtoTypeCongesEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CongesPersistDtoTypeCongesEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CongesPersistDtoTypeCongesEnum] to String,
/// and [decode] dynamic data back to [CongesPersistDtoTypeCongesEnum].
class CongesPersistDtoTypeCongesEnumTypeTransformer {
  factory CongesPersistDtoTypeCongesEnumTypeTransformer() => _instance ??= const CongesPersistDtoTypeCongesEnumTypeTransformer._();

  const CongesPersistDtoTypeCongesEnumTypeTransformer._();

  String encode(CongesPersistDtoTypeCongesEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CongesPersistDtoTypeCongesEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CongesPersistDtoTypeCongesEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data.toString()) {
        case r'CONGE_PAYE': return CongesPersistDtoTypeCongesEnum.CONGE_PAYE;
        case r'MALADIE': return CongesPersistDtoTypeCongesEnum.MALADIE;
        case r'SANS_SOLDE': return CongesPersistDtoTypeCongesEnum.SANS_SOLDE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CongesPersistDtoTypeCongesEnumTypeTransformer] instance.
  static CongesPersistDtoTypeCongesEnumTypeTransformer? _instance;
}


