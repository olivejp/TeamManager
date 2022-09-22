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
    this.dateFin,
    required this.typeConges,
  });

  int teammateId;

  DateTime dateDebut;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? dateFin;

  CongesCreateDtoTypeCongesEnum typeConges;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CongesCreateDto &&
     other.teammateId == teammateId &&
     other.dateDebut == dateDebut &&
     other.dateFin == dateFin &&
     other.typeConges == typeConges;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (teammateId.hashCode) +
    (dateDebut.hashCode) +
    (dateFin == null ? 0 : dateFin!.hashCode) +
    (typeConges.hashCode);

  @override
  String toString() => 'CongesCreateDto[teammateId=$teammateId, dateDebut=$dateDebut, dateFin=$dateFin, typeConges=$typeConges]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'teammateId'] = teammateId;
      _json[r'dateDebut'] = dateDebut.toUtc().toIso8601String();
    if (dateFin != null) {
      _json[r'dateFin'] = dateFin!.toUtc().toIso8601String();
    }
      _json[r'typeConges'] = typeConges;
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
        dateFin: mapDateTime(json, r'dateFin', ''),
        typeConges: CongesCreateDtoTypeCongesEnum.fromJson(json[r'typeConges'])!,
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
    'typeConges',
  };
}


class CongesCreateDtoTypeCongesEnum {
  /// Instantiate a new enum with the provided [value].
  const CongesCreateDtoTypeCongesEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const AM = CongesCreateDtoTypeCongesEnum._(r'AM');
  static const PM = CongesCreateDtoTypeCongesEnum._(r'PM');
  static const ALL_DAY = CongesCreateDtoTypeCongesEnum._(r'ALL_DAY');

  /// List of all possible values in this [enum][CongesCreateDtoTypeCongesEnum].
  static const values = <CongesCreateDtoTypeCongesEnum>[
    AM,
    PM,
    ALL_DAY,
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
        case r'AM': return CongesCreateDtoTypeCongesEnum.AM;
        case r'PM': return CongesCreateDtoTypeCongesEnum.PM;
        case r'ALL_DAY': return CongesCreateDtoTypeCongesEnum.ALL_DAY;
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


