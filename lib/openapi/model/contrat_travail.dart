//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ContratTravail {
  /// Returns a new [ContratTravail] instance.
  ContratTravail({
    this.id,
    this.typeContratTravail,
    this.dateDebut,
    this.dateFin,
    this.observation,
    this.teammate,
    this.listDocument = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? id;

  ContratTravailTypeContratTravailEnum? typeContratTravail;

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

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? observation;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Teammate? teammate;

  List<Document> listDocument;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ContratTravail &&
     other.id == id &&
     other.typeContratTravail == typeContratTravail &&
     other.dateDebut == dateDebut &&
     other.dateFin == dateFin &&
     other.observation == observation &&
     other.teammate == teammate &&
     other.listDocument == listDocument;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (typeContratTravail == null ? 0 : typeContratTravail!.hashCode) +
    (dateDebut == null ? 0 : dateDebut!.hashCode) +
    (dateFin == null ? 0 : dateFin!.hashCode) +
    (observation == null ? 0 : observation!.hashCode) +
    (teammate == null ? 0 : teammate!.hashCode) +
    (listDocument.hashCode);

  @override
  String toString() => 'ContratTravail[id=$id, typeContratTravail=$typeContratTravail, dateDebut=$dateDebut, dateFin=$dateFin, observation=$observation, teammate=$teammate, listDocument=$listDocument]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    if (id != null) {
      _json[r'id'] = id;
    }
    if (typeContratTravail != null) {
      _json[r'typeContratTravail'] = typeContratTravail;
    }
    if (dateDebut != null) {
      _json[r'dateDebut'] = dateDebut!.toUtc().toIso8601String();
    }
    if (dateFin != null) {
      _json[r'dateFin'] = dateFin!.toUtc().toIso8601String();
    }
    if (observation != null) {
      _json[r'observation'] = observation;
    }
    if (teammate != null) {
      _json[r'teammate'] = teammate;
    }
      _json[r'listDocument'] = listDocument;
    return _json;
  }

  /// Returns a new [ContratTravail] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ContratTravail? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ContratTravail[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ContratTravail[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ContratTravail(
        id: mapValueOfType<int>(json, r'id'),
        typeContratTravail: ContratTravailTypeContratTravailEnum.fromJson(json[r'typeContratTravail']),
        dateDebut: mapDateTime(json, r'dateDebut', ''),
        dateFin: mapDateTime(json, r'dateFin', ''),
        observation: mapValueOfType<String>(json, r'observation'),
        teammate: Teammate.fromJson(json[r'teammate']),
        listDocument: Document.listFromJson(json[r'listDocument']) ?? const [],
      );
    }
    return null;
  }

  static List<ContratTravail>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ContratTravail>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ContratTravail.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ContratTravail> mapFromJson(dynamic json) {
    final map = <String, ContratTravail>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ContratTravail.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ContratTravail-objects as value to a dart map
  static Map<String, List<ContratTravail>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ContratTravail>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ContratTravail.listFromJson(entry.value, growable: growable,);
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


class ContratTravailTypeContratTravailEnum {
  /// Instantiate a new enum with the provided [value].
  const ContratTravailTypeContratTravailEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const CDD = ContratTravailTypeContratTravailEnum._(r'CDD');
  static const CDI = ContratTravailTypeContratTravailEnum._(r'CDI');
  static const CDIC = ContratTravailTypeContratTravailEnum._(r'CDIC');

  /// List of all possible values in this [enum][ContratTravailTypeContratTravailEnum].
  static const values = <ContratTravailTypeContratTravailEnum>[
    CDD,
    CDI,
    CDIC,
  ];

  static ContratTravailTypeContratTravailEnum? fromJson(dynamic value) => ContratTravailTypeContratTravailEnumTypeTransformer().decode(value);

  static List<ContratTravailTypeContratTravailEnum>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ContratTravailTypeContratTravailEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ContratTravailTypeContratTravailEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ContratTravailTypeContratTravailEnum] to String,
/// and [decode] dynamic data back to [ContratTravailTypeContratTravailEnum].
class ContratTravailTypeContratTravailEnumTypeTransformer {
  factory ContratTravailTypeContratTravailEnumTypeTransformer() => _instance ??= const ContratTravailTypeContratTravailEnumTypeTransformer._();

  const ContratTravailTypeContratTravailEnumTypeTransformer._();

  String encode(ContratTravailTypeContratTravailEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a ContratTravailTypeContratTravailEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ContratTravailTypeContratTravailEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data.toString()) {
        case r'CDD': return ContratTravailTypeContratTravailEnum.CDD;
        case r'CDI': return ContratTravailTypeContratTravailEnum.CDI;
        case r'CDIC': return ContratTravailTypeContratTravailEnum.CDIC;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ContratTravailTypeContratTravailEnumTypeTransformer] instance.
  static ContratTravailTypeContratTravailEnumTypeTransformer? _instance;
}


