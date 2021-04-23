import 'package:books_app/data/models/volumes.dart';
import 'package:retrofit/retrofit.dart';

import 'package:dio/dio.dart';

part 'api.g.dart';

const String apiKey = "AIzaSyB6evM_BbeqnZ8GIqHTDGwcgxXCCBJ8zlE";
const String sort_by_newest = "newest";
const String sort_by_relevance = "relevance";
const Map<String, String> headers = {
  "x-rapidapi-key": "326713088emsh32774d1e886ae24p1d9715jsncbeea767b6db",
  "x-rapidapi-host": "google-books.p.rapidapi.com"
};
const String filter_all = "all";
const String filter_books = "books";
const String filter_magazines = "magazines";

@RestApi(baseUrl: "https://google-books.p.rapidapi.com/")
abstract class BooksApi {
  static const String _key = "key";
  static const String _startIndex = "startIndex";
  static const String _maxResults = "maxResults";
  static const String _orderBy = "orderBy";
  static const String _printType = "printType";

  factory BooksApi(Dio dio) => _BooksApi(dio);

  @GET("/volumes")
  Future<Volumes> getAllVolumes(
      {@Query(_key) String apiKeyParam = apiKey,
      @Query(_orderBy) String orderedByParam = sort_by_relevance,
      @Query(_startIndex) int startIndex = 0,
      @Query(_maxResults) int maxResults = 10,
      @Query(_printType) String printType = filter_all});
}
