//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DashboardDto {
  /// Returns a new [DashboardDto] instance.
  DashboardDto({
    this.type,
    this.nbJours,
  });

  DashboardDtoTypeEnum? type;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? nbJours;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DashboardDto &&
     other.type == type &&
     other.nbJours == nbJours;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (type == null ? 0 : type!.hashCode) +
    (nbJours == null ? 0 : nbJours!.hashCode);

  @override
  String toString() => 'DashboardDto[type=$type, nbJours=$nbJours]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    if (type != null) {
      _json[r'type'] = type;
    }
    if (nbJours != null) {
      _json[r'nbJours'] = nbJours;
    }
    return _json;
  }

  /// Returns a new [DashboardDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DashboardDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DashboardDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DashboardDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DashboardDto(
        type: DashboardDtoTypeEnum.fromJson(json[r'type']),
        nbJours: mapValueOfType<int>(json, r'nbJours'),
      );
    }
    return null;
  }

  static List<DashboardDto>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DashboardDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DashboardDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DashboardDto> mapFromJson(dynamic json) {
    final map = <String, DashboardDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DashboardDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DashboardDto-objects as value to a dart map
  static Map<String, List<DashboardDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DashboardDto>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DashboardDto.listFromJson(entry.value, growable: growable,);
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


class DashboardDtoTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const DashboardDtoTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const CONGE_PAYE = DashboardDtoTypeEnum._(r'CONGE_PAYE');
  static const MALADIE = DashboardDtoTypeEnum._(r'MALADIE');
  static const SANS_SOLDE = DashboardDtoTypeEnum._(r'SANS_SOLDE');

  /// List of all possible values in this [enum][DashboardDtoTypeEnum].
  static const values = <DashboardDtoTypeEnum>[
    CONGE_PAYE,
    MALADIE,
    SANS_SOLDE,
  ];

  static DashboardDtoTypeEnum? fromJson(dynamic value) => DashboardDtoTypeEnumTypeTransformer().decode(value);

  static List<DashboardDtoTypeEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DashboardDtoTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DashboardDtoTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [DashboardDtoTypeEnum] to String,
/// and [decode] dynamic data back to [DashboardDtoTypeEnum].
class DashboardDtoTypeEnumTypeTransformer {
  factory DashboardDtoTypeEnumTypeTransformer() => _instance ??= const DashboardDtoTypeEnumTypeTransformer._();

  const DashboardDtoTypeEnumTypeTransformer._();

  String encode(DashboardDtoTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a DashboardDtoTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  DashboardDtoTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data.toString()) {
        case r'CONGE_PAYE': return DashboardDtoTypeEnum.CONGE_PAYE;
        case r'MALADIE': return DashboardDtoTypeEnum.MALADIE;
        case r'SANS_SOLDE': return DashboardDtoTypeEnum.SANS_SOLDE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [DashboardDtoTypeEnumTypeTransformer] instance.
  static DashboardDtoTypeEnumTypeTransformer? _instance;
}


