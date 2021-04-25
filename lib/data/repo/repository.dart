import 'package:books_app/data/api/api.dart';
import 'package:books_app/data/api/constants.dart';
import 'package:books_app/data/api/search_api.dart';
import 'package:books_app/domain/models/volumes.dart';
import 'package:books_app/domain/repository/repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

@Singleton(as: BooksRepository)
class BooksRepositoryImpl implements BooksRepository {
  late BooksApi booksApi;
  late SearchApi searchApi;
  late Logger logger = Logger();

  BooksRepositoryImpl() {
    final dio = Dio();
    dio.options.headers = headers;
    this.booksApi = BooksApi(dio);
    this.searchApi = SearchApi(dio);
  }

  @override
  Future<VolumesModel> getAllBooks({int startIndex = 0,
    int maxResults = 20,
    SortedByType sortedByType = SortedByType.relevance,
    FilterByPrintType printType = FilterByPrintType.all}) async {
    String printTypeValue = filter_all;
    if (printType == FilterByPrintType.books)
      printTypeValue = filter_books;
    else if (printType == FilterByPrintType.magazines)
      printTypeValue = filter_magazines;

    final apiResult = await booksApi.getAllVolumes(
        startIndex: startIndex,
        maxResults: maxResults,
        orderedByParam: sortedByType == SortedByType.relevance
            ? sort_by_relevance
            : sort_by_newest,
        printType: printTypeValue).then((result) {
      logger.d(result);
      return result;
    });
    return apiResult.toDomain();
  }

  @override
  Future<VolumesModel> search(String keyWord, SearchIn whereSearch,
      {int startIndex = 0,
        int maxResults = 20,
        SortedByType sortedByType = SortedByType.relevance,
        FilterByPrintType printType = FilterByPrintType.all}) async {
    String printTypeValue = filter_all;
    if (printType == FilterByPrintType.books)
      printTypeValue = filter_books;
    else if (printType == FilterByPrintType.magazines)
      printTypeValue = filter_magazines;

    final words = keyWord.split(" ");
    String key;
    if (whereSearch == SearchIn.title) {
      key = '$intitle:${words.join("+")}';
    } else {
      key = '$inauthor:${words.join("+")}';
    }

    final apiResult = await searchApi.search(
        key,
        startIndex: startIndex,
        maxResults: maxResults,
        orderedByParam: sortedByType == SortedByType.relevance
            ? sort_by_relevance
            : sort_by_newest,
        printType: printTypeValue).then((result) {
      logger.d(result);
      return result;
    });

    return apiResult.toDomain();
  }
}
