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
      SortedByType sortedByType = SortedByType.relevance,
      FilterByPrintType printType = FilterByPrintType.all}) async {
    String printTypeValue = filter_all;
    if (printType == FilterByPrintType.books)
      printTypeValue = filter_books;
    else if (printType == FilterByPrintType.magazines)
      printTypeValue = filter_magazines;

    final apiResult = await api.getAllVolumes(
        startIndex: startIndex,
        maxResults: maxResults,
        orderedByParam: sortedByType == SortedByType.relevance
            ? sort_by_relevance
            : sort_by_newest,
        printType: printTypeValue);
    return apiResult.toDomain();
  }
}
