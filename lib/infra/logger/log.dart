import 'dart:io';

import 'package:simple_logger/simple_logger.dart';

abstract class Log {
  static final _logger = SimpleLogger();

  static bool get _isTest => Platform.environment.containsKey('FLUTTER_TEST');

  static void i(String message) {
    if (_isTest) {
      return;
    }

    _logger.info(message);
  }

  static void w(String warning) {
    if (_isTest) {
      return;
    }

    _logger.shout(warning);
  }

  static void e(String error, {Object? data, StackTrace? trace}) {
    if (_isTest) {
      return;
    }

    String message = "";

    if (data != null) {
      message = "\n\n${data.toString()}";
    }

    if (trace != null) {
      message += "\n\n${trace.toString()}";
    }

    message = "$error$message";

    _logger.shout(message);
  }
}
