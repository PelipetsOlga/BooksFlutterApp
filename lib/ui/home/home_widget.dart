import 'dart:developer';

import 'package:books_app/domain/models/items.dart';
import 'package:books_app/domain/repository/repository.dart';
import 'package:books_app/navigation/first/router_home.dart';
import 'package:books_app/ui/book/book_page.dart';
import 'package:books_app/ui/common/listtile/listtile.dart';
import 'package:books_app/ui/home/home_view_model.dart';
import 'package:books_app/ui/common/filter/modal_fit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../injection.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late BooksRepository repository;
  late HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    repository = getIt.get();
    viewModel = HomeViewModel(repository);
    viewModel.reload();
  }

  @override
  void dispose() {
    viewModel.dispose();
    log("dispose state");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => viewModel,
      child: SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: Container(
            child: ValueListenableBuilder<List<ItemsModel>>(
              valueListenable: viewModel,
              builder: (BuildContext context, List<ItemsModel> items,
                  Widget? child) {
                if (viewModel.isLoading() && items.isEmpty)
                  return _buildLoadingView();
                else if (items.isEmpty)
                  return _buildEmptyView();
                else
                  return _buildListView(items);
              },
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
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

  Center _buildLoadingView() => Center(child: CircularProgressIndicator());

  Text _buildEmptyView() => Text('No data');

  NotificationListener<ScrollNotification> _buildListView(
      List<ItemsModel> items) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo is ScrollEndNotification &&
            scrollInfo.metrics.extentAfter == 0) {
          viewModel.getMore();
          return true;
        }
        return false;
      },
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index];
          return buildListTile(item, context, () => onItemClick(item));
        },
        separatorBuilder: (context, index) => Divider(height: 2),
        cacheExtent: 5,
      ),
    );
  }

  void onItemClick(ItemsModel item) {
    FocusScope.of(context).focusedChild?.unfocus();
    Navigator.of(context)
        .pushNamed(RouterHome.home_book, arguments: BookPageArgs(item));
  }
}
