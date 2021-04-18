import 'package:books_app/domain/models/epub.dart';
import 'package:json_annotation/json_annotation.dart';

part 'epub.g.dart';

@JsonSerializable()
class Epub {
  bool isAvailable;
  String? downloadLink;

  Epub({required this.isAvailable, required this.downloadLink});

  factory Epub.fromJson(Map<String, dynamic> json) => _$EpubFromJson(json);

  Map<String, dynamic> toJson() => _$EpubToJson(this);

  EpubModel toDomain() => EpubModel(isAvailable, downloadLink);
}
