import 'package:books_app/domain/models/item_like.dart';
import 'package:books_app/domain/models/items.dart';
import 'package:flutter/material.dart';

import '../book_decorator.dart';
import '../like.dart';

Widget buildListTile(
    ItemLikeModel item, BuildContext context, Function clickListener) {
  return Padding(
      padding: EdgeInsets.only(top: 4, bottom: 16, left: 16, right: 4),
      child: GestureDetector(
        onTap: () {
          clickListener();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: getImage(item.item, context, 150),
            ),
            SizedBox(width: 24),
            _getRightPart(item, context),
          ],
        ),
      ));
}

Widget _getRightPart(ItemLikeModel item, BuildContext context) {
  return Flexible(
    child: Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerRight,
            width: double.infinity,
            child: LikeClass(item.isLiked, Theme.of(context).accentColor,
                size: 36),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...getAuthors(item.item, context),
              ...getTitle(item.item, context, false),
              ...getRating(item.item)
            ],
          ),
        ],
      ),
    ),
  );
}
