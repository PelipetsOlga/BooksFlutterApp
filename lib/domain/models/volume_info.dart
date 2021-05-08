import 'package:books_app/domain/models/image_links.dart';
import 'package:books_app/domain/models/industry_identifiers.dart';
import 'package:books_app/domain/models/penelisation_summary.dart';
import 'package:books_app/domain/models/reading_models.dart';

class VolumeInfoModel {
  String title;
  List<String>? authors;
  String? publisher;
  String? publishedDate;
  String? description;
  List<IndustryIdentifiersModel>? industryIdentifiers;
  ReadingModesModel readingModes;
  int? pageCount;
  String? printType;
  List<String>? categories;
  String maturityRating;
  bool allowAnonLogging;
  String contentVersion;
  PanelizationSummaryModel? panelizationSummary;
  ImageLinksModel? imageLinks;
  String language;
  String previewLink;
  String infoLink;
  String canonicalVolumeLink;
  String? subtitle;
  double? averageRating;
  int? ratingsCount;

  VolumeInfoModel(
      this.title,
      this.authors,
      this.publisher,
      this.publishedDate,
      this.description,
      this.industryIdentifiers,
      this.readingModes,
      this.pageCount,
      this.printType,
      this.categories,
      this.maturityRating,
      this.allowAnonLogging,
      this.contentVersion,
      this.panelizationSummary,
      this.imageLinks,
      this.language,
      this.previewLink,
      this.infoLink,
      this.canonicalVolumeLink,
      this.subtitle,
      this.averageRating,
      this.ratingsCount);
}
