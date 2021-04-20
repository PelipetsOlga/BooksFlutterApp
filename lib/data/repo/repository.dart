import 'package:books_app/data/api/api.dart';
import 'package:books_app/domain/models/volumes.dart';
import 'package:books_app/domain/repository/repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

@Singleton(as: BooksRepository)
class BooksRepositoryImpl implements BooksRepository {
  late BooksApi api;

  BooksRepositoryImpl() {
    final dio = Dio();
    dio.options.headers = BooksApi.headers;
    this.api = BooksApi(dio);
  }

  @override
  Future<VolumesModel> getAllBooks() async {
    final apiResult = await api.getAllVolumes(BooksApi.apiKey);
    return apiResult.toDomain();
  }
}