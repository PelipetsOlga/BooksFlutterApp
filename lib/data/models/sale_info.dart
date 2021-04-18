import 'package:books_app/domain/models/sale_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sale_info.g.dart';

@JsonSerializable()
class SaleInfo {
  String country;
  String saleability;
  bool isEbook;
  String? buyLink;

  SaleInfo(
      {required this.country,
      required this.saleability,
      required this.isEbook,
      required this.buyLink});

  factory SaleInfo.fromJson(Map<String, dynamic> json) =>
      _$SaleInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SaleInfoToJson(this);

  SaleInfoModel toDomain() =>
      SaleInfoModel(country, saleability, isEbook, buyLink);
}
