/**
 * Created by YHF at 13:57 on 2022-03-24.
 */

import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:ourdate/constant/Constant.dart';
import 'package:path_provider/path_provider.dart';

/// 输出Log工具类

enum Level { verbose, debug, info, warning, error }

class Log {
  static const String tag = '';

  static d(dynamic msg, {tag: tag}) {
    evPrint(msg, Level.debug);
  }

  static i(dynamic msg, {tag: tag}) {
    evPrint(msg, Level.info);
  }

  static e(dynamic msg, {tag: tag}) {
    evPrint(msg, Level.error);
  }

  static evPrint(dynamic msg, Level level) {
    String log = _LogSimplePrinter.format(level, tag, msg);
    String time = DateUtil.formatDate(DateTime.now(),format: "yyyy-MM-dd HH:mm:ss.SSS");
    String content = time+" / "+log;
    print(content);
    LogsStorage.instance.writeLogsToFile(content);
  }
}


class _LogSimplePrinter {

  static final levelPrefixes = {
    Level.verbose: 'V/',
    Level.debug: 'D/',
    Level.info: 'I/',
    Level.warning: 'W/',
    Level.error: 'E/',
  };

  static String format(Level level, String tag, dynamic content) {
    return '${levelPrefixes[level]} $tag ${content.toString()}\n';
  }

}

class LogsStorage {
  static final LogsStorage _singleton = LogsStorage._();

  static String logDir = "/wineLog/";
  static LogsStorage get instance => _singleton;
  LogsStorage._() {
    deleteExpireLog();
  }

  Future<String?> get _localPath async {
    var directory;
    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
      return directory.path;
    } else {
      return ConstantPath.KDROID;
    }
  }

  File? _file;
  Future<File?> get _localFile async {
    final path = (await _localPath)! + logDir;
    await Directory(path).create().then((dir) {
      print(path);
    });
    DateTime now = DateTime.now();
    String time = "${now.year}${now.month}${now.day}";
    var file = File("$path$time" + ".txt");
    var isExist = await file.exists();
    if (!isExist) {
      file.createSync();
    }
    _file = file;
    return _file;
  }

  void writeLogsToFile(String log) async {
    if (_file == null) {
      await _localFile;
    }
    _file!.writeAsStringSync('$log\n', mode: FileMode.writeOnlyAppend);
  }

  Future deleteExpireLog() async {
    try {
      final path = (await _localPath)! + logDir;
      var fiveDayBefore = DateTime.now().subtract(Duration(days: 30));
      Directory(path).list().where((value) {
        var file = File(value.path);
        if (file == null || !file.existsSync()) {
          return false;
        }
        DateTime dateTime = file.lastModifiedSync();
        if (dateTime.isBefore(fiveDayBefore)) {
          file.delete();
        }
        return true;
      }).toList();
    } catch (e) {
      print(e);
    }
  }
}
