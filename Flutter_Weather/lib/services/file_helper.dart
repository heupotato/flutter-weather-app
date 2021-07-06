import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileHelper {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  static Future<FileSystemEntity?> deleteFile(String fileName) async {
    final file = await _localFile(fileName);
    final exists = await file.exists();
    if (exists) {
      return file.delete();
    }
  }

  static Future<File> writeDataToFile(dynamic data, String fileName) async {
    final file = await _localFile(fileName);
    return file.writeAsString(jsonEncode(data));
  }
}
