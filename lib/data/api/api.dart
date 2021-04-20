import 'package:books_app/data/models/volumes.dart';
import 'package:retrofit/retrofit.dart';

import 'package:dio/dio.dart';

part 'api.g.dart';

@RestApi(baseUrl: "https://google-books.p.rapidapi.com/")
abstract class BooksApi {
  static const String _key = "key";
  static const String apiKey = "AIzaSyB6evM_BbeqnZ8GIqHTDGwcgxXCCBJ8zlE";
  static const Map<String, String> headers = {
    "x-rapidapi-key": "326713088emsh32774d1e886ae24p1d9715jsncbeea767b6db",
    "x-rapidapi-host": "google-books.p.rapidapi.com"
  };
  static const String _startIndex = "startIndex";
  static const String _maxResults = "maxResults";

  factory BooksApi(Dio dio) => _BooksApi(dio);

  @GET("/volumes?key=AIzaSyB6evM_BbeqnZ8GIqHTDGwcgxXCCBJ8zlE")
  Future<Volumes> getAllVolumes(@Query(_key) String apiKey,
      {@Query(_startIndex) int startIndex = 0,
      @Query(_maxResults) int maxResults = 10});
}
