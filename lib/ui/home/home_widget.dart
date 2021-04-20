import 'package:books_app/domain/models/items.dart';
import 'package:books_app/domain/models/volumes.dart';
import 'package:books_app/domain/repository/repository.dart';
import 'package:books_app/tools/logger.dart';
import 'package:flutter/material.dart';

import '../../injection.dart';

class HomeScreen extends StatelessWidget {
  late Log logger;
  final logTag = "HomeScreen";

  @override
  Widget build(BuildContext context) {
    final repository = getIt.get<BooksRepository>();

    return Scaffold(
      appBar: AppBar(title: Text("Books")),
      body: FutureBuilder(
        future: repository.getAllBooks(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data != null &&
              snapshot.data is VolumesModel &&
              (snapshot.data as VolumesModel).items.length > 0) {
            return _buildListView(snapshot.data as VolumesModel);
          }
          if (snapshot.data != null) {
            return Center(child: Text("There are some other data in snapshot"));
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  ListView _buildListView(VolumesModel volumesModel) {
    return ListView.builder(
        itemCount: volumesModel.items.length,
        itemBuilder: (context, index) {
          final thumbnailUrl =
              volumesModel.items[index].volumeInfo.imageLinks?.thumbnail;
          return Card(
            child: ListTile(
              title: Text(volumesModel.items[index].volumeInfo.title),
              subtitle: Text(_getAuthors(volumesModel.items[index])),
              leading: thumbnailUrl != null
                  ? new Image.network(thumbnailUrl)
                  : Icon(Icons.book),
            ),
          );
        });
  }

  String _getAuthors(ItemsModel item) {
    final authors = item.volumeInfo.authors;
    if (authors == null || authors.isEmpty) return "";
    return authors.join(", ");
  }
}
