import 'dart:io';

import 'package:flutter_weather/packages/dahttp/dahttp.dart';
import 'package:dart_date/dart_date.dart';
import 'package:f_logs/f_logs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logger {
  static const TODAY_LOG_DATE_KEY = 'today_log_date_id';

  static Future<DateTime?> _loadLogDate() async {
    final preferences = await SharedPreferences.getInstance();
    final timestamp = preferences.getInt(TODAY_LOG_DATE_KEY);
    if (timestamp != null) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      return dateTime;
    } else {
      return null;
    }
  }

  static _saveLogDate() async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt(TODAY_LOG_DATE_KEY, timestamp);
  }

  static _checkAndClearLogIfNeeded() async {
    DateTime? logDate = await _loadLogDate();
    if (logDate == null || !logDate.isToday) {
      await _saveLogDate();
      await FLog.clearLogs();
    }
  }

  static String get platform {
    return Platform.operatingSystem + ' ' + Platform.operatingSystemVersion;
  }

  static Future<File> exportLogs() async => FLog.exportLogs();

  static logInfo(
      {required String className,
      required String methodName,
      required String message}) async {
    await _checkAndClearLogIfNeeded();
    FLog.info(className: className, methodName: methodName, text: message);
  }

  static logError(
      {required String className,
      required String methodName,
      required String message}) async {
    await _checkAndClearLogIfNeeded();
    FLog.error(className: className, methodName: methodName, text: message);
  }

  static logResultError(
      {required String className,
      required String methodName,
      required HttpResult result}) async {
    await _checkAndClearLogIfNeeded();
    if (result.exception != null) {
      FLog.error(
          className: className,
          methodName: methodName,
          text: '${result.exception.toString()}');
    } else {
      FLog.error(
          className: className,
          methodName: methodName,
          text: '${result.response.body.toString()}');
    }
  }
}
