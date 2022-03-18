abstract class AbstractDomain<T> {
  AbstractDomain({this.id});

  T? id;
  dynamic createDate;
  dynamic updateDate;
  String? creatorUid;

  T? getId();

  AbstractDomain<T> fromJson(Map<String, dynamic> map);

  Map<String, dynamic> toJson();
}