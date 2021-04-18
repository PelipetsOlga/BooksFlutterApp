import 'package:books_app/domain/models/items.dart';

class VolumesModel {
  String kind;
  int totalItems;
  List<ItemsModel> items;

  VolumesModel(this.kind, this.totalItems, this.items);
}
