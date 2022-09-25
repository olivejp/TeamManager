//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PageCustomerDto {
  /// Returns a new [PageCustomerDto] instance.
  PageCustomerDto({
    this.totalPages,
    this.totalElements,
    this.first,
    this.last,
    this.size,
    this.content = const [],
    this.number,
    this.sort,
    this.numberOfElements,
    this.pageable,
    this.empty,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? totalPages;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? totalElements;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? first;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? last;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? size;

  List<CustomerDto> content;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? number;

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
  int? numberOfElements;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  PageableObject? pageable;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? empty;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PageCustomerDto &&
     other.totalPages == totalPages &&
     other.totalElements == totalElements &&
     other.first == first &&
     other.last == last &&
     other.size == size &&
     other.content == content &&
     other.number == number &&
     other.sort == sort &&
     other.numberOfElements == numberOfElements &&
     other.pageable == pageable &&
     other.empty == empty;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (totalPages == null ? 0 : totalPages!.hashCode) +
    (totalElements == null ? 0 : totalElements!.hashCode) +
    (first == null ? 0 : first!.hashCode) +
    (last == null ? 0 : last!.hashCode) +
    (size == null ? 0 : size!.hashCode) +
    (content.hashCode) +
    (number == null ? 0 : number!.hashCode) +
    (sort == null ? 0 : sort!.hashCode) +
    (numberOfElements == null ? 0 : numberOfElements!.hashCode) +
    (pageable == null ? 0 : pageable!.hashCode) +
    (empty == null ? 0 : empty!.hashCode);

  @override
  String toString() => 'PageCustomerDto[totalPages=$totalPages, totalElements=$totalElements, first=$first, last=$last, size=$size, content=$content, number=$number, sort=$sort, numberOfElements=$numberOfElements, pageable=$pageable, empty=$empty]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    if (totalPages != null) {
      _json[r'totalPages'] = totalPages;
    }
    if (totalElements != null) {
      _json[r'totalElements'] = totalElements;
    }
    if (first != null) {
      _json[r'first'] = first;
    }
    if (last != null) {
      _json[r'last'] = last;
    }
    if (size != null) {
      _json[r'size'] = size;
    }
      _json[r'content'] = content;
    if (number != null) {
      _json[r'number'] = number;
    }
    if (sort != null) {
      _json[r'sort'] = sort;
    }
    if (numberOfElements != null) {
      _json[r'numberOfElements'] = numberOfElements;
    }
    if (pageable != null) {
      _json[r'pageable'] = pageable;
    }
    if (empty != null) {
      _json[r'empty'] = empty;
    }
    return _json;
  }

  /// Returns a new [PageCustomerDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PageCustomerDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PageCustomerDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PageCustomerDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PageCustomerDto(
        totalPages: mapValueOfType<int>(json, r'totalPages'),
        totalElements: mapValueOfType<int>(json, r'totalElements'),
        first: mapValueOfType<bool>(json, r'first'),
        last: mapValueOfType<bool>(json, r'last'),
        size: mapValueOfType<int>(json, r'size'),
        content: CustomerDto.listFromJson(json[r'content']) ?? const [],
        number: mapValueOfType<int>(json, r'number'),
        sort: SortObject.fromJson(json[r'sort']),
        numberOfElements: mapValueOfType<int>(json, r'numberOfElements'),
        pageable: PageableObject.fromJson(json[r'pageable']),
        empty: mapValueOfType<bool>(json, r'empty'),
      );
    }
    return null;
  }

  static List<PageCustomerDto>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PageCustomerDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PageCustomerDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PageCustomerDto> mapFromJson(dynamic json) {
    final map = <String, PageCustomerDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PageCustomerDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PageCustomerDto-objects as value to a dart map
  static Map<String, List<PageCustomerDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PageCustomerDto>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PageCustomerDto.listFromJson(entry.value, growable: growable,);
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

