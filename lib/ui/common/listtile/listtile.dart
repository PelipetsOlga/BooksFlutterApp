import 'package:books_app/domain/models/items.dart';
import 'package:flutter/material.dart';

import '../book_decorator.dart';

Widget buildListTile(
    ItemsModel item, BuildContext context, Function clickListener) {
  return Padding(
      padding: EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {
          clickListener();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            getImage(item, context, 150),
            SizedBox(width: 24),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...getAuthors(item, context),
                    ...getTitle(item, context, false),
                    ...getRating(item)
                  ],
                ),
              ),
            ),
          ],
        ),
      ));
}
