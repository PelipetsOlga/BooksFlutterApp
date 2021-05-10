import 'dart:developer';

import 'package:books_app/domain/models/item_like.dart';
import 'package:books_app/domain/repository/repository.dart';
import 'package:books_app/ui/common/filter/common_books_list_view_model.dart';
import 'package:books_app/ui/common/filter/filter_view_model.dart';
import 'package:flutter/material.dart';

const minSymbolsCountForSearch = 3;

class SearchViewModel extends ValueNotifier<SearchResults>
    implements CommonBooksListViewModel {
  BooksRepository repository;
  int pageNumberByTitle = 0;
  int pageNumberByAuthor = 0;
  int _batchesOf = 20;
  final List<ItemLikeModel> _itemsByTitle = [];
  final List<ItemLikeModel> _itemsByAuthor = [];
  late FilterViewModel filterViewModel;
  late SearchResults searchResults;
  String _searchKey = "";

  SearchViewModel(this.repository) : super(SearchResults.emptyResults) {
    filterViewModel = FilterViewModel(this);
    searchResults = new SearchResults(_itemsByTitle, _itemsByAuthor);
  }

  @override
  SearchResults get value => searchResults;

  void setSearchKey(String key) {
    if (_searchKey == key) return;
    _searchKey = key;
    reload();
  }

  void addItemsByTitle(List<ItemLikeModel> list) {
    _itemsByTitle.addAll(list);
    notifyListeners();
  }

  void addItemsByAuthor(List<ItemLikeModel> list) {
    _itemsByAuthor.addAll(list);
    notifyListeners();
  }

  @override
  Future<void> reload() async {
    log("reload model");
    pageNumberByTitle = 0;
    pageNumberByAuthor = 0;
    _itemsByTitle.clear();
    _itemsByAuthor.clear();
    if (_searchKey.trim().length >= minSymbolsCountForSearch) {
      getMoreByTitle();
      getMoreByAuthor();
    } else {
      notifyListeners();
    }
  }

  Future<void> getMoreByTitle() async {
    final result = await repository.search(_searchKey, SearchIn.title,
        startIndex: pageNumberByTitle * _batchesOf,
        maxResults: _batchesOf,
        sortedByType: filterViewModel.getSortedType(),
        printType: filterViewModel.getFilterByPrintType());
    pageNumberByTitle++;
    addItemsByTitle(result);
  }

  Future<void> getMoreByAuthor() async {
    final result = await repository.search(_searchKey, SearchIn.author,
        startIndex: pageNumberByTitle * _batchesOf,
        maxResults: _batchesOf,
        sortedByType: filterViewModel.getSortedType(),
        printType: filterViewModel.getFilterByPrintType());
    pageNumberByAuthor++;
    addItemsByAuthor(result);
  }
}

class SearchResults {
  List<ItemLikeModel> itemsByTitle;

  List<ItemLikeModel> itemsByAuthor;

  SearchResults(this.itemsByTitle, this.itemsByAuthor);

  bool isEmpty() => itemsByTitle.isEmpty && itemsByAuthor.isEmpty;

  static final emptyResults = new SearchResults([], []);
}
