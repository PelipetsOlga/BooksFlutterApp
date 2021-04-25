import 'package:books_app/domain/models/access_info.dart';
import 'package:books_app/domain/models/sale_info.dart';
import 'package:books_app/domain/models/search_info.dart';
import 'package:books_app/domain/models/volume_info.dart';

class ItemsModel {
  String kind;
  String id;
  String etag;
  String selfLink;
  VolumeInfoModel? volumeInfo;
  SaleInfoModel saleInfo;
  AccessInfoModel accessInfo;
  SearchInfoModel? searchInfo;

  ItemsModel(this.kind, this.id, this.etag, this.selfLink, this.volumeInfo,
      this.saleInfo, this.accessInfo, this.searchInfo);
}
