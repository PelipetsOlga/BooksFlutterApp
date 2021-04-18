import 'package:books_app/domain/models/image_links.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_links.g.dart';

@JsonSerializable()
class ImageLinks {
  String smallThumbnail;
  String thumbnail;

  ImageLinks({required this.smallThumbnail, required this.thumbnail});

  factory ImageLinks.fromJson(Map<String, dynamic> json) =>
      _$ImageLinksFromJson(json);

  Map<String, dynamic> toJson() => _$ImageLinksToJson(this);

  ImageLinksModel toDomain() => ImageLinksModel(smallThumbnail, thumbnail);
}