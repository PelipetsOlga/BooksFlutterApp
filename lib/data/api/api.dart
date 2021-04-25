import 'package:books_app/data/models/volumes.dart';
import 'package:retrofit/retrofit.dart';

import 'package:dio/dio.dart';

import 'constants.dart';

part 'api.g.dart';

@RestApi(baseUrl: booksUrl)
abstract class BooksApi {

  factory BooksApi(Dio dio) => _BooksApi(dio);

  @GET("/volumes")
  Future<Volumes> getAllVolumes(
      {@Query(key) String apiKeyParam = apiKey,
      @Query(orderBy) String orderedByParam = sort_by_relevance,
      @Query(startIndex) int startIndex = 0,
      @Query(maxResults) int maxResults = 10,
      @Query(printType) String printType = filter_all});
}
