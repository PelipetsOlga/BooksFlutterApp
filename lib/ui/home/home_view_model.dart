import 'dart:developer';

import 'package:books_app/domain/models/items.dart';
import 'package:books_app/domain/repository/repository.dart';
import 'package:books_app/ui/common/filter/common_books_list_view_model.dart';
import 'package:books_app/ui/common/filter/filter_view_model.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ValueNotifier<List<ItemsModel>>
    implements CommonBooksListViewModel {
  BooksRepository repository;
  int pageNumber = 0;
  bool _hasMore = true;
  int _batchesOf = 20;
  bool _loading = false;
  final List<ItemsModel> _items = [];
  late FilterViewModel filterViewModel;

  HomeViewModel(this.repository) : super([]) {
    filterViewModel = FilterViewModel(this);
  }

  @override
  List<ItemsModel> get value => _items;

  void addItems(List<ItemsModel> list) {
    _items.addAll(list);
    notifyListeners();
  }

  void _setIsLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool isLoading() => _loading;

  @override
  Future<void> reload() async {
    log("reload model");
    pageNumber = 0;
    _hasMore = true;
    _setIsLoading(false);
    _items.clear();
    getMore();
  }

  @override
  Future<void> getMore() async {
    if (_hasMore && !_loading) {
      _setIsLoading(true);
      final result = await repository.getAllBooks(
          startIndex: pageNumber * _batchesOf,
          maxResults: _batchesOf,
          sortedByType: filterViewModel.getSortedType(),
          printType: filterViewModel.getFilterByPrintType());
      _setIsLoading(false);
      pageNumber++;
      addItems(result.items);
    }
  }
}
