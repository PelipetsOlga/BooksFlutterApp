import 'package:books_app/domain/models/volumes.dart';
import 'package:json_annotation/json_annotation.dart';

import 'items.dart';

part 'volumes.g.dart';

@JsonSerializable()
class Volumes {
  String kind;
  int totalItems;
  List<Items> items;

  Volumes({required this.kind, required this.totalItems, required this.items});

  factory Volumes.fromJson(Map<String, dynamic> json) =>
      _$VolumesFromJson(json);

  Map<String, dynamic> toJson() => _$VolumesToJson(this);

  VolumesModel toDomain() =>
      VolumesModel(kind, totalItems, items.map((e) => e.toDomain()).toList());
}
