import 'package:books_app/domain/models/industry_identifiers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'industry_identifiers.g.dart';

@JsonSerializable()
class IndustryIdentifiers {
  String type;
  String identifier;

  IndustryIdentifiers({required this.type, required this.identifier});

  factory IndustryIdentifiers.fromJson(Map<String, dynamic> json) =>
      _$IndustryIdentifiersFromJson(json);

  Map<String, dynamic> toJson() => _$IndustryIdentifiersToJson(this);

  IndustryIdentifiersModel toDomain() =>
      IndustryIdentifiersModel(type, identifier);
}
