import 'package:books_app/domain/models/items.dart';
import 'package:books_app/ui/common/book_decorator.dart';
import 'package:books_app/ui/common/colors.dart';
import 'package:flutter/material.dart';

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
    final title = item.volumeInfo?.title;
    return Scaffold(
      appBar: AppBar(),
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
}
