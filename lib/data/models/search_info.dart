import 'package:json_annotation/json_annotation.dart';

part 'search_info.g.dart';

@JsonSerializable()
class SearchInfo {
  String textSnippet;

  SearchInfo({required this.textSnippet});

  factory SearchInfo.fromJson(Map<String, dynamic> json) =>
      _$SearchInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SearchInfoToJson(this);
}