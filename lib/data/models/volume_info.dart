import 'package:books_app/domain/models/volume_info.dart';
import 'package:json_annotation/json_annotation.dart';

import 'image_links.dart';
import 'industry_identifiers.dart';
import 'penelisation_summary.dart';
import 'reading_models.dart';

part 'volume_info.g.dart';

@JsonSerializable()
class VolumeInfo {
  String title;
  List<String>? authors;
  String? publishedDate;
  List<IndustryIdentifiers> industryIdentifiers;
  ReadingModes readingModes;
  int? pageCount;
  String printType;
  List<String>? categories;
  String maturityRating;
  bool allowAnonLogging;
  String contentVersion;
  PanelizationSummary? panelizationSummary;
  ImageLinks? imageLinks;
  String language;
  String previewLink;
  String infoLink;
  String canonicalVolumeLink;
  String? subtitle;
  double? averageRating;
  int? ratingsCount;

  VolumeInfo(
      {required this.title,
      required this.authors,
      required this.publishedDate,
      required this.industryIdentifiers,
      required this.readingModes,
      required this.pageCount,
      required this.printType,
      required this.categories,
      required this.maturityRating,
      required this.allowAnonLogging,
      required this.contentVersion,
      required this.panelizationSummary,
      required this.imageLinks,
      required this.language,
      required this.previewLink,
      required this.infoLink,
      required this.canonicalVolumeLink,
      required this.subtitle,
      required this.averageRating,
      required this.ratingsCount});

  factory VolumeInfo.fromJson(Map<String, dynamic> json) =>
      _$VolumeInfoFromJson(json);

  Map<String, dynamic> toJson() => _$VolumeInfoToJson(this);

  VolumeInfoModel toDomain() => VolumeInfoModel(
      title,
      authors,
      publishedDate,
      industryIdentifiers.map((e) => e.toDomain()).toList(),
      readingModes.toDomain(),
      pageCount,
      printType,
      categories,
      maturityRating,
      allowAnonLogging,
      contentVersion,
      panelizationSummary?.toDomain(),
      imageLinks?.toDomain(),
      language,
      previewLink,
      infoLink,
      canonicalVolumeLink,
      subtitle,
      averageRating,
      ratingsCount);
}
