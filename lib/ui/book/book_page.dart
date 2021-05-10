import 'dart:io';

import 'package:books_app/domain/models/item_like.dart';
import 'package:books_app/ui/common/book_decorator.dart';
import 'package:books_app/ui/common/like.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class BookPageArgs {
  ItemLikeModel data;

  BookPageArgs(this.data);
}

class BookPage extends StatelessWidget {
  BookPageArgs args;

  BookPage(this.args);

  @override
  Widget build(BuildContext context) {
    final item = args.data.item;
    return Scaffold(
      appBar: _buildAppBar(context, args.data),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getImage(item, context, 200),
                SizedBox(height: 24),
                ...getAuthors(item, context),
                ...getTitle(item, context, true),
                ...getRating(item),
                ...getCategories(item, context),
                ...getPublisher(item, context),
                ...getDescription(item, context),
                ...getReaderLink(item, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, ItemLikeModel item) {
    var link = args.data.item.volumeInfo?.canonicalVolumeLink;
    if (link != null && link.isNotEmpty && Platform.isAndroid)
      return AppBar(actions: <Widget>[
        _likeAction(context, item),
        _shareAction(link),
      ]);
    else
      return AppBar(actions: <Widget>[
        _likeAction(context, item),
      ]);
  }

  Padding _shareAction(String link) {
    return Padding(
        padding: EdgeInsets.only(right: 16.0),
        child: GestureDetector(
          onTap: () {
            Share.share('Google book is here $link', subject: 'Take a look!');
          },
          child: Icon(Icons.share),
        ));
  }

  Padding _likeAction(BuildContext context, ItemLikeModel item) {
    return Padding(
        padding: EdgeInsets.only(right: 16.0),
        child: GestureDetector(
            onTap: () {},
            child: LikeClass(
                item.isLiked,
                Theme.of(context).appBarTheme.actionsIconTheme?.color ??
                    Colors.red)));
  }
}
