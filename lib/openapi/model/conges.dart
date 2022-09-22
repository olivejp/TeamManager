//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Conges {
  /// Returns a new [Conges] instance.
  Conges({
    this.id,
    this.teammate,
    this.dateDebut,
    this.dateFin,
    this.typeConges,
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
  Teammate? teammate;

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

  CongesTypeCongesEnum? typeConges;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Conges &&
     other.id == id &&
     other.teammate == teammate &&
     other.dateDebut == dateDebut &&
     other.dateFin == dateFin &&
     other.typeConges == typeConges;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (teammate == null ? 0 : teammate!.hashCode) +
    (dateDebut == null ? 0 : dateDebut!.hashCode) +
    (dateFin == null ? 0 : dateFin!.hashCode) +
    (typeConges == null ? 0 : typeConges!.hashCode);

  @override
  String toString() => 'Conges[id=$id, teammate=$teammate, dateDebut=$dateDebut, dateFin=$dateFin, typeConges=$typeConges]';

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
    return _json;
  }

  /// Returns a new [Conges] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Conges? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Conges[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Conges[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Conges(
        id: mapValueOfType<int>(json, r'id'),
        teammate: Teammate.fromJson(json[r'teammate']),
        dateDebut: mapDateTime(json, r'dateDebut', ''),
        dateFin: mapDateTime(json, r'dateFin', ''),
        typeConges: CongesTypeCongesEnum.fromJson(json[r'typeConges']),
      );
    }
    return null;
  }

  static List<Conges>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Conges>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Conges.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Conges> mapFromJson(dynamic json) {
    final map = <String, Conges>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Conges.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Conges-objects as value to a dart map
  static Map<String, List<Conges>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Conges>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Conges.listFromJson(entry.value, growable: growable,);
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


class CongesTypeCongesEnum {
  /// Instantiate a new enum with the provided [value].
  const CongesTypeCongesEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const AM = CongesTypeCongesEnum._(r'AM');
  static const PM = CongesTypeCongesEnum._(r'PM');
  static const ALL_DAY = CongesTypeCongesEnum._(r'ALL_DAY');

  /// List of all possible values in this [enum][CongesTypeCongesEnum].
  static const values = <CongesTypeCongesEnum>[
    AM,
    PM,
    ALL_DAY,
  ];

  static CongesTypeCongesEnum? fromJson(dynamic value) => CongesTypeCongesEnumTypeTransformer().decode(value);

  static List<CongesTypeCongesEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CongesTypeCongesEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CongesTypeCongesEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CongesTypeCongesEnum] to String,
/// and [decode] dynamic data back to [CongesTypeCongesEnum].
class CongesTypeCongesEnumTypeTransformer {
  factory CongesTypeCongesEnumTypeTransformer() => _instance ??= const CongesTypeCongesEnumTypeTransformer._();

  const CongesTypeCongesEnumTypeTransformer._();

  String encode(CongesTypeCongesEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CongesTypeCongesEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CongesTypeCongesEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data.toString()) {
        case r'AM': return CongesTypeCongesEnum.AM;
        case r'PM': return CongesTypeCongesEnum.PM;
        case r'ALL_DAY': return CongesTypeCongesEnum.ALL_DAY;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CongesTypeCongesEnumTypeTransformer] instance.
  static CongesTypeCongesEnumTypeTransformer? _instance;
}


