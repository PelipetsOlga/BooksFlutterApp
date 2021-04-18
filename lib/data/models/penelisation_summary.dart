import 'package:json_annotation/json_annotation.dart';

part 'penelisation_summary.g.dart';

@JsonSerializable()
class PanelizationSummary {
  bool containsEpubBubbles;
  bool containsImageBubbles;

  PanelizationSummary(
      {required this.containsEpubBubbles, required this.containsImageBubbles});

  factory PanelizationSummary.fromJson(Map<String, dynamic> json) =>
      _$PanelizationSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$PanelizationSummaryToJson(this);
}
