import 'dart:developer';

import 'package:books_app/data/api/api.dart';
import 'package:books_app/domain/models/volumes.dart';
import 'package:books_app/domain/repository/repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

@Singleton(as: BooksRepository)
class BooksRepositoryImpl implements BooksRepository {
  late BooksApi api;

  BooksRepositoryImpl() {
    final dio = Dio();
    dio.options.headers = headers;
    this.api = BooksApi(dio);
  }

  @override
  Future<VolumesModel> getAllBooks(
      {int startIndex = 0,
      int maxResults = 20,
      SortedByType sortedByType = SortedByType.relevance}) async {
    final apiResult = await api.getAllVolumes(
        startIndex: startIndex,
        maxResults: maxResults,
        orderedByParam:
            sortedByType == SortedByType.relevance ? relevance : newest);
    log("repo  apiResult size = ${apiResult.items.length}");
    return apiResult.toDomain();
  }
}
