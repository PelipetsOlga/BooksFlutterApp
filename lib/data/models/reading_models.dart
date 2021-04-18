import 'package:books_app/domain/models/reading_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reading_models.g.dart';

@JsonSerializable()
class ReadingModes {
  bool text;
  bool image;

  ReadingModes({required this.text, required this.image});

  factory ReadingModes.fromJson(Map<String, dynamic> json) =>
      _$ReadingModesFromJson(json);

  Map<String, dynamic> toJson() => _$ReadingModesToJson(this);

  ReadingModesModel toDomain() => ReadingModesModel(text, image);
}
