import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@singleton
class Log {
  final logger = Logger();

  log(String tag, String msg) => logger.d(tag, msg);

  error(String tag, String msg) => logger.e(tag, msg);
}
