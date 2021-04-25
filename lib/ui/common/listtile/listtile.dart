import 'package:books_app/domain/models/items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../colors.dart';

Widget buildListTile(ItemsModel item, BuildContext context) {
  final thumbnailUrl = item.volumeInfo?.imageLinks?.thumbnail;
  final title = item.volumeInfo?.title;
  return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(border: Border.all(width: 0.5)),
              child: thumbnailUrl != null
                  ? FadeInImage.assetNetwork(
                      placeholder: 'assets/icons/book_placeholder.png',
                      // Before image load
                      image: thumbnailUrl,
                      // After image load
                      height: 150,
                      width: 150,
                      fit: BoxFit.fitHeight,
                    )
                  : Image.asset(
                      'assets/icons/book_placeholder.png', // After image load
                      height: 150,
                      width: 150,
                    )),
          SizedBox(width: 24),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_getAuthors(item),
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: AppColors.gray3)),
                  SizedBox(height: 16),
                  Text(title ?? "no_title",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  ..._getRating(item)
                ],
              ),
            ),
          ),
        ],
      ));
}

String _getAuthors(ItemsModel item) {
  final authors = item.volumeInfo?.authors;
  if (authors == null || authors.isEmpty) return "";
  return authors.join(", ");
}

List<Widget> _getRating(ItemsModel item) {
  final rating = item.volumeInfo?.averageRating;
  if (rating == null)
    return [];
  else
    return [
      SizedBox(height: 8),
      RatingBarIndicator(
        rating: rating,
        itemBuilder: (context, index) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        itemCount: 5,
        itemSize: 20.0,
        direction: Axis.horizontal,
      )
    ];
}
