import 'package:books_app/data/models/volumes.dart';
import 'package:retrofit/retrofit.dart';

import 'package:dio/dio.dart';

import 'constants.dart';

part 'search_api.g.dart';

@RestApi(baseUrl: searchUrl)
abstract class SearchApi {

  factory SearchApi(Dio dio) => _SearchApi(dio);

  @GET("/books/v1/volumes")
  Future<Volumes> search(@Query(searchQ) String keyWord,
      {@Query(orderBy) String orderedByParam = sort_by_relevance,
      @Query(startIndex) int startIndex = 0,
      @Query(maxResults) int maxResults = 10,
      @Query(printType) String printType = filter_all,
      @Query(key) String apiKeyParam = apiKey});
}
