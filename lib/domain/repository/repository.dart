import 'package:books_app/domain/models/volumes.dart';

abstract class BooksRepository {

  Future<VolumesModel> getAllBooks();
}