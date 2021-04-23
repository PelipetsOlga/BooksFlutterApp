import 'package:books_app/domain/repository/repository.dart';
import 'package:books_app/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';

class ModalFit extends StatefulWidget {
  HomeViewModel viewModel;

  ModalFit(this.viewModel);

  @override
  State<StatefulWidget> createState() => ModalFitState();
}

class ModalFitState extends State<ModalFit> {
  late HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    this._viewModel = widget.viewModel;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 16),
          getSortedBySection(),
          SizedBox(height: 8),
          getFilterByPrintTypeSection(),
          ListTile(
            title: Text('Edit'),
            leading: Icon(Icons.edit),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text('Copy'),
            leading: Icon(Icons.content_copy),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text('Cut'),
            leading: Icon(Icons.content_cut),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text('Move'),
            leading: Icon(Icons.folder_open),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text('Delete'),
            leading: Icon(Icons.delete),
            onTap: () => Navigator.of(context).pop(),
          )
        ],
      ),
    ));
  }

  Wrap getSortedBySection() {
    return Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text("Sorted by", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      SizedBox(width: 16),
      ChoiceChip(
        label: Text("Relevance"),
        selected: _viewModel.getSortedType() == SortedByType.relevance,
        onSelected: (bool selected) {
          if (selected) {
            setState(() {
              _viewModel.setSortedByRelevance();
            });
          }
        },
      ),
      SizedBox(width: 8),
      ChoiceChip(
        label: Text("Newest"),
        selected: _viewModel.getSortedType() == SortedByType.newest,
        onSelected: (bool selected) {
          if (selected) {
            setState(() {
              _viewModel.setSortedByNewest();
            });
          }
        },
      )
    ]);
  }

  Wrap getFilterByPrintTypeSection() {
    return Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text("Filter", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      SizedBox(width: 16),
      ChoiceChip(
        label: Text("All"),
        selected: _viewModel.getFilterByPrintType() == FilterByPrintType.all,
        onSelected: (bool selected) {
          if (selected) {
            setState(() {
              _viewModel.setFilterByPrintTypeAll();
            });
          }
        },
      ),
      SizedBox(width: 8),
      ChoiceChip(
        label: Text("Books"),
        selected: _viewModel.getFilterByPrintType() == FilterByPrintType.books,
        onSelected: (bool selected) {
          if (selected) {
            setState(() {
              _viewModel.setFilterByPrintTypeBooks();
            });
          }
        },
      ),
      SizedBox(width: 8),
      ChoiceChip(
        label: Text("Magazines"),
        selected: _viewModel.getFilterByPrintType() == FilterByPrintType.magazines,
        onSelected: (bool selected) {
          if (selected) {
            setState(() {
              _viewModel.setFilterByPrintTypeMagazines();
            });
          }
        },
      )
    ]);
  }
}
