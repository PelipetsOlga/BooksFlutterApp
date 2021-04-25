import 'dart:developer';

import 'package:books_app/domain/models/items.dart';
import 'package:books_app/domain/repository/repository.dart';
import 'package:books_app/ui/common/colors.dart';
import 'package:books_app/ui/common/filter/modal_fit.dart';
import 'package:books_app/ui/common/listtile/listtile.dart';
import 'package:books_app/ui/search/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

import '../../injection.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late BooksRepository repository;
  late SearchViewModel viewModel;
  TextEditingController textController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    repository = getIt.get();
    viewModel = SearchViewModel(repository);
    textController.addListener(_handleSearchKey);
    viewModel.reload();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _handleSearchKey() {
    viewModel.setSearchKey(textController.text);
  }

  @override
  void dispose() {
    viewModel.dispose();
    textController.dispose();
    _tabController.dispose();
    log("dispose state");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModel>(
      create: (context) => viewModel,
      child: SafeArea(
        child: Scaffold(
          appBar: _getAppBar(context),
          body: Container(
            color: AppColors.pageBackground,
            child: ValueListenableBuilder<SearchResults>(
              valueListenable: viewModel,
              builder: (BuildContext context, SearchResults searchResults,
                  Widget? child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _getSearchBar(),
                    _getTabs(),
                    _getContent(searchResults),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      title: Text("Books"),
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => showMaterialModalBottomSheet(
                expand: false,
                context: context,
                elevation: 16,
                backgroundColor: Colors.transparent,
                builder: (context) => ModalFit(viewModel.filterViewModel),
              ),
              child: Icon(Icons.more_vert),
            )),
      ],
    );
  }

  Padding _getSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: AnimSearchBar(
        width: 800,
        autoFocus: true,
        color: Colors.lightBlueAccent,
        textController: textController,
        onSuffixTap: () {
          setState(() {
            textController.clear();
          });
        },
      ),
    );
  }

  Widget _getTabs() {
    return Card(
      elevation: 4,
      child: Container(
        height: 48,
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2,
                color: Colors.orange,
              ),
            ),
          ),
          tabs: [_getLeftTab(), _getRightTab()],
        ),
      ),
    );
  }

  Tab _getLeftTab() {
    return Tab(
        child: Text(
      "Books",
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.bodyText1,
    ));
  }

  Tab _getRightTab() {
    return Tab(
        child: Text(
      "Authors",
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.bodyText1,
    ));
  }

  Widget _getContent(SearchResults searchResults) {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          _getLeftTabBarView(searchResults),
          _getRightTabBarView(searchResults)
        ],
      ),
    );
  }

  Widget _getLeftTabBarView(SearchResults searchResults) {
    return _buildListViewByTitle(searchResults.itemsByTitle);
  }

  Widget _getRightTabBarView(SearchResults searchResults) {
    return _buildListViewByAuthor(searchResults.itemsByAuthor);
  }

  NotificationListener<ScrollNotification> _buildListViewByTitle(
      List<ItemsModel> items) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo is ScrollEndNotification &&
            scrollInfo.metrics.extentAfter == 0) {
          viewModel.getMoreByTitle();
          return true;
        }
        return false;
      },
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return buildListTile(items[index], context);
        },
        separatorBuilder: (context, index) => Divider(height: 2),
        cacheExtent: 5,
      ),
    );
  }

  NotificationListener<ScrollNotification> _buildListViewByAuthor(
      List<ItemsModel> items) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo is ScrollEndNotification &&
            scrollInfo.metrics.extentAfter == 0) {
          viewModel.getMoreByAuthor();
          return true;
        }
        return false;
      },
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return buildListTile(items[index], context);
        },
        separatorBuilder: (context, index) => Divider(height: 2),
        cacheExtent: 5,
      ),
    );
  }
}
