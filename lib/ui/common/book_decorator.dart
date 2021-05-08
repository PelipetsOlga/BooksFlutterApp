import 'package:books_app/domain/models/items.dart';
import 'package:books_app/ui/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

Widget getImage(ItemsModel item, BuildContext context, double size) {
  final thumbnailUrl = item.volumeInfo?.imageLinks?.thumbnail;
  return Container(
      decoration: BoxDecoration(border: Border.all(width: 0.5)),
      child: thumbnailUrl != null
          ? FadeInImage.assetNetwork(
              placeholder: 'assets/icons/book_placeholder.png',
              image: thumbnailUrl,
              height: size,
              width: size,
              fit: BoxFit.fitHeight,
            )
          : Image.asset(
              'assets/icons/book_placeholder.png', // After image load
              height: size,
              width: size,
            ));
}

List<Widget> getTitle(ItemsModel item, BuildContext context, bool centred) {
  final title = item.volumeInfo?.title;
  return title != null
      ? [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(fontWeight: FontWeight.bold),
            textAlign: centred ? TextAlign.center : TextAlign.start,
          ),
        ]
      : [];
}

List<Widget> getAuthors(ItemsModel item, BuildContext context) {
  final authors = item.volumeInfo?.authors;
  if (authors == null || authors.isEmpty)
    return [];
  else
    return [
      Text(authors.join(", "),
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: AppColors.gray3)),
      SizedBox(height: 16),
    ];
}

List<Widget> getRating(ItemsModel item) {
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
      ),
      SizedBox(height: 8),
    ];
}

List<Widget> getCategories(ItemsModel item, BuildContext context) {
  final categoriess = item.volumeInfo?.categories;
  if (categoriess == null || categoriess.isEmpty) return [];
  var list =
      categoriess.map((category) => Chip(label: Text(category))).toList();
  return [SizedBox(height: 8), ...list, SizedBox(height: 8)];
}

List<Widget> getPublisher(ItemsModel item, BuildContext context) {
  final publisher = item.volumeInfo?.publisher;
  final publishedDate = item.volumeInfo?.publishedDate;
  final pageCount = item.volumeInfo?.pageCount;
  TextStyle style = Theme.of(context).textTheme.bodyText1!;

  if (publisher != null && publishedDate != null)
    return [
      Text(
        "$publisher, $publishedDate${pageCount != null ? ', ' : ''}${pageCount != null ? pageCount : ''}${pageCount != null ? ' pages' : ''}",
        style: style,
      ),
      SizedBox(height: 16)
    ];
  else if (publisher != null)
    return [
      Text(
        "$publisher${pageCount != null ? ', ' : ''}${pageCount != null ? pageCount : ''}${pageCount != null ? ' pages' : ''}",
        style: style,
      ),
      SizedBox(height: 16)
    ];
  else if (publishedDate != null)
    return [
      Text(
        "$publishedDate${pageCount != null ? ', ' : ''}${pageCount != null ? pageCount : ''}${pageCount != null ? ' pages' : ''}",
        style: style,
      ),
      SizedBox(height: 16)
    ];
  else if (pageCount != null)
    return [
      Text(
        "$pageCount pages",
        style: style,
      ),
      SizedBox(height: 16)
    ];
  else
    return [];
}

List<Widget> getDescription(ItemsModel item, BuildContext context) {
  final description = item.volumeInfo?.description;
  TextStyle style = Theme.of(context)
      .textTheme
      .bodyText2!
      .copyWith(fontStyle: FontStyle.italic)
      .copyWith(color: AppColors.gray3);

  if (description != null)
    return [
      Text(description, style: style, textAlign: TextAlign.justify),
      SizedBox(height: 16)
    ];
  else
    return [];
}

List<Widget> getReaderLink(ItemsModel item, BuildContext context) {
  final link = item.accessInfo.webReaderLink;
  TextStyle style = Theme.of(context)
      .textTheme
      .bodyText2!
      .copyWith(fontStyle: FontStyle.italic)
      .copyWith(color: AppColors.blue);

  if (link.isNotEmpty)
    return [
      TextButton(
          onPressed: () => _launchURL(link),
          child: Text("Read more", style: style, textAlign: TextAlign.start)),
      SizedBox(height: 16)
    ];
  else
    return [];
}

void _launchURL(String _url) async {
  if (await canLaunch(_url)) {
    await launch(_url);
  }
}
