import 'package:books_app/data/api/api.dart';
import 'package:books_app/domain/models/volumes.dart';
import 'package:books_app/domain/repository/repository.dart';

class BooksRepositoryImpl implements BooksRepository {
  BooksApi api;

  BooksRepositoryImpl(this.api);

  @override
  Future<VolumesModel> getAllBooks() async {
    final apiResult = await api.getAllVolumes(BooksApi.apiKey);
    return apiResult.toDomain();
  }
}