import 'package:books_app/domain/repository/repository.dart';

import 'common_books_list_view_model.dart';

class FilterViewModel {
  CommonBooksListViewModel parentViewModel;
  SortedByType _sortedByType = SortedByType.relevance;
  FilterByPrintType _filterByPrintType = FilterByPrintType.all;

  FilterViewModel(this.parentViewModel);

  SortedByType getSortedType() => _sortedByType;

  void setSortedByNewest() {
    _sortedByType = SortedByType.newest;
    parentViewModel.reload();
  }

  void setSortedByRelevance() {
    _sortedByType = SortedByType.relevance;
    parentViewModel.reload();
  }

  FilterByPrintType getFilterByPrintType() => _filterByPrintType;

  void setFilterByPrintTypeAll() {
    _filterByPrintType = FilterByPrintType.all;
    parentViewModel.reload();
  }

  void setFilterByPrintTypeBooks() {
    _filterByPrintType = FilterByPrintType.books;
    parentViewModel.reload();
  }

  void setFilterByPrintTypeMagazines() {
    _filterByPrintType = FilterByPrintType.magazines;
    parentViewModel.reload();
  }
}
