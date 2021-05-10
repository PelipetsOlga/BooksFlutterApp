import 'package:books_app/domain/models/items.dart';

class ItemLikeModel {
  ItemsModel item;
  bool isLiked;

  ItemLikeModel(this.item, this.isLiked);
}
