//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PageableObject {
  /// Returns a new [PageableObject] instance.
  PageableObject({
    this.offset,
    this.sort,
    this.paged,
    this.unpaged,
    this.pageNumber,
    this.pageSize,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? offset;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  SortObject? sort;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? paged;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? unpaged;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? pageNumber;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? pageSize;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PageableObject &&
     other.offset == offset &&
     other.sort == sort &&
     other.paged == paged &&
     other.unpaged == unpaged &&
     other.pageNumber == pageNumber &&
     other.pageSize == pageSize;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (offset == null ? 0 : offset!.hashCode) +
    (sort == null ? 0 : sort!.hashCode) +
    (paged == null ? 0 : paged!.hashCode) +
    (unpaged == null ? 0 : unpaged!.hashCode) +
    (pageNumber == null ? 0 : pageNumber!.hashCode) +
    (pageSize == null ? 0 : pageSize!.hashCode);

  @override
  String toString() => 'PageableObject[offset=$offset, sort=$sort, paged=$paged, unpaged=$unpaged, pageNumber=$pageNumber, pageSize=$pageSize]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    if (offset != null) {
      _json[r'offset'] = offset;
    }
    if (sort != null) {
      _json[r'sort'] = sort;
    }
    if (paged != null) {
      _json[r'paged'] = paged;
    }
    if (unpaged != null) {
      _json[r'unpaged'] = unpaged;
    }
    if (pageNumber != null) {
      _json[r'pageNumber'] = pageNumber;
    }
    if (pageSize != null) {
      _json[r'pageSize'] = pageSize;
    }
    return _json;
  }

  /// Returns a new [PageableObject] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PageableObject? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PageableObject[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PageableObject[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PageableObject(
        offset: mapValueOfType<int>(json, r'offset'),
        sort: SortObject.fromJson(json[r'sort']),
        paged: mapValueOfType<bool>(json, r'paged'),
        unpaged: mapValueOfType<bool>(json, r'unpaged'),
        pageNumber: mapValueOfType<int>(json, r'pageNumber'),
        pageSize: mapValueOfType<int>(json, r'pageSize'),
      );
    }
    return null;
  }

  static List<PageableObject>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PageableObject>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PageableObject.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PageableObject> mapFromJson(dynamic json) {
    final map = <String, PageableObject>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PageableObject.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PageableObject-objects as value to a dart map
  static Map<String, List<PageableObject>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PageableObject>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PageableObject.listFromJson(entry.value, growable: growable,);
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

