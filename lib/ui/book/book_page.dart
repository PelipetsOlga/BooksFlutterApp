import 'dart:io';

import 'package:books_app/domain/models/items.dart';
import 'package:books_app/ui/common/book_decorator.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class BookPageArgs {
  ItemsModel data;

  BookPageArgs(this.data);
}

class BookPage extends StatelessWidget {
  BookPageArgs args;

  BookPage(this.args);

  @override
  Widget build(BuildContext context) {
    final item = args.data;
    return Scaffold(
      appBar: _buildAppBar(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    var link = args.data.volumeInfo?.canonicalVolumeLink;
    if (link != null && link.isNotEmpty && Platform.isAndroid)
      return AppBar(actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Share.share('Google book is here $link',
                    subject: 'Take a look!');
              },
              child: Icon(Icons.share),
            )),
      ]);
    else
      return AppBar();
  }
}
