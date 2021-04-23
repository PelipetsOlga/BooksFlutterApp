import 'dart:developer';

import 'package:books_app/domain/models/items.dart';
import 'package:books_app/domain/repository/repository.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ValueNotifier<List<ItemsModel>> {
  BooksRepository repository;
  int pageNumber = 0;
  bool _hasMore = true;
  int _batchesOf = 20;
  bool _loading = false;
  final List<ItemsModel> _items = [];
  SortedByType _sortedByType = SortedByType.relevance;
  FilterByPrintType _filterByPrintType = FilterByPrintType.all;

  HomeViewModel(this.repository) : super([]);

  @override
  List<ItemsModel> get value => _items;

  void addItems(List<ItemsModel> list) {
    log("addItems to model");
    list.forEach((element) {
      log("${element.volumeInfo.title}) ");
    });
    _items.addAll(list);
    notifyListeners();
  }

  void _setIsLoading(bool value) {
    log("_setIsLoading $value in model");
    _loading = value;
    notifyListeners();
  }

  bool isLoading() => _loading;

  Future<void> reload() async {
    log("reload model");
    pageNumber = 0;
    _hasMore = true;
    _setIsLoading(false);
    _items.clear();
    getMore();
  }

  Future<void> getMore() async {
    log("getMore in model");
    if (_hasMore && !_loading) {
      _setIsLoading(true);
      final result = await repository.getAllBooks(
          startIndex: pageNumber * _batchesOf,
          maxResults: _batchesOf,
          sortedByType: _sortedByType,
          printType: _filterByPrintType);
      _setIsLoading(false);
      pageNumber++;
      addItems(result.items);
    }
  }

  SortedByType getSortedType() => _sortedByType;

  void setSortedByNewest() {
    _sortedByType = SortedByType.newest;
    reload();
  }

  void setSortedByRelevance() {
    _sortedByType = SortedByType.relevance;
    reload();
  }

  FilterByPrintType getFilterByPrintType() => _filterByPrintType;

  void setFilterByPrintTypeAll() {
    _filterByPrintType = FilterByPrintType.all;
    reload();
  }

  void setFilterByPrintTypeBooks() {
    _filterByPrintType = FilterByPrintType.books;
    reload();
  }

  void setFilterByPrintTypeMagazines() {
    _filterByPrintType = FilterByPrintType.magazines;
    reload();
  }
}
