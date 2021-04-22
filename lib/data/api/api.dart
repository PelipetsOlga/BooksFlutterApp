import 'package:books_app/data/models/volumes.dart';
import 'package:retrofit/retrofit.dart';

import 'package:dio/dio.dart';

part 'api.g.dart';

const String apiKey = "AIzaSyB6evM_BbeqnZ8GIqHTDGwcgxXCCBJ8zlE";
const String newest = "newest";
const String relevance = "relevance";
const Map<String, String> headers = {
  "x-rapidapi-key": "326713088emsh32774d1e886ae24p1d9715jsncbeea767b6db",
  "x-rapidapi-host": "google-books.p.rapidapi.com"
};

@RestApi(baseUrl: "https://google-books.p.rapidapi.com/")
abstract class BooksApi {
  static const String _key = "key";
  static const String _startIndex = "startIndex";
  static const String _maxResults = "maxResults";
  static const String _orderBy = "orderBy";

  factory BooksApi(Dio dio) => _BooksApi(dio);

  @GET("/volumes")
  Future<Volumes> getAllVolumes(
      {@Query(_key) String apiKeyParam = apiKey,
      @Query(_orderBy) String orderedByParam = relevance,
      @Query(_startIndex) int startIndex = 0,
      @Query(_maxResults) int maxResults = 10});
}
