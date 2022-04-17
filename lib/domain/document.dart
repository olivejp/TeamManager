import 'package:json_annotation/json_annotation.dart';

import 'abstract.domain.dart';

part 'document.g.dart';

@JsonSerializable()
class Document extends AbstractDomain<int> {
  Document();

  String? url;
  String? filename;

  factory Document.fromJson(Map<String, dynamic> json) => _$DocumentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DocumentToJson(this);

  @override
  int? getId() {
    return id;
  }

  @override
  AbstractDomain<int> fromJson(Map<String, dynamic> map) {
    return Document.fromJson(map);
  }
}
