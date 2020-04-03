import 'package:logger/logger.dart';

class CustomLogPrinter extends LogPrinter {
  final String className;

  CustomLogPrinter(this.className);

  @override
  void log(Level level, message, error, StackTrace stackTrace) {
    var emoji = PrettyPrinter.levelEmojis[level];
    return print('$emoji $className - $message');
  }
}

Logger getLogger(String className) {
  return Logger(printer: CustomLogPrinter(className));
}
