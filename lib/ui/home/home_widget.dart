import 'dart:developer';

import 'package:books_app/domain/models/items.dart';
import 'package:books_app/domain/repository/repository.dart';
import 'package:books_app/ui/common/colors.dart';
import 'package:books_app/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../injection.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late BooksRepository repository;
  late HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    log("Init state");
    repository = getIt.get();
    viewModel = HomeViewModel(repository);
    viewModel.getMore();
  }

  @override
  void dispose() {
    viewModel.dispose();
    log("dispose state");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Books")),
      body: Container(
        color: AppColors.pageBackground,
        child: ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel(repository),
          child: ValueListenableBuilder<List<ItemsModel>>(
            valueListenable: viewModel,
            builder:
                (BuildContext context, List<ItemsModel> items, Widget? child) {
              log("onBuild of ValueListenableBuilder");
              if (viewModel.isLoading() && items.isEmpty)
                return Center(child: CircularProgressIndicator());
              else if (items.isEmpty)
                return Text('No data');
              else
                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo is ScrollEndNotification &&
                        scrollInfo.metrics.extentAfter == 0) {
                      viewModel.getMore();
                      return true;
                    }
                    return false;
                  },
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return _buildListTile(items[index]);
                    },
                    separatorBuilder: (context, index) => Divider(height: 2),
                    cacheExtent: 5,
                  ),
                );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(ItemsModel item) {
    final thumbnailUrl = item.volumeInfo.imageLinks?.thumbnail;
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
                    Text(item.volumeInfo.title,
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
    final authors = item.volumeInfo.authors;
    if (authors == null || authors.isEmpty) return "";
    return authors.join(", ");
  }

  List<Widget> _getRating(ItemsModel item) {
    final rating = item.volumeInfo.averageRating;
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
}
