import 'package:books_app/domain/models/volumes.dart';

abstract class BooksRepository {
  Future<VolumesModel> getAllBooks(
      {int startIndex,
      int maxResults,
      SortedByType sortedByType,
      FilterByPrintType printType});

  Future<VolumesModel> search(String keyWord, SearchIn whereSearch,
      {int startIndex,
      int maxResults,
      SortedByType sortedByType,
      FilterByPrintType printType});
}

enum SortedByType { relevance, newest }

enum FilterByPrintType { all, books, magazines }

enum SearchIn { title, author }
