import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

abstract class AbstractLocalStorage<T> {
  AbstractLocalStorage.object(
      {required this.fileName, required this.fromJson, required this.toJson});

  AbstractLocalStorage.list(
      {required this.fileName,
      required this.fromJsonList,
      required this.toJson});

  T Function(Map<String, dynamic> json)? fromJson;
  List<T> Function(List<dynamic> response)? fromJsonList;
  Map<String, dynamic> Function(T) toJson;

  final String fileName;
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    final appDataDirectory = Directory(directory.path + '/app_data');
    if (await appDataDirectory.exists()) {
      print(appDataDirectory.path);
      return appDataDirectory.path;
    } else {
      await appDataDirectory.create();
      return appDataDirectory.path;
    }
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/$fileName');
  }

  Future<FileSystemEntity?> clear() async {
    final file = await localFile;
    final exists = await file.exists();
    if (exists) {
      return file.delete();
    }
  }

  Future<List<T>> readItems() async {
    if (fromJsonList == null) return [];
    try {
      final file = await localFile;
      final contents = await file.readAsString();
      final List<dynamic> jsons = json.decode(contents);
      print(jsons);
      return fromJsonList!(jsons);
    } catch (e) {
      print("readItems err msg" + e.toString());
      return [];
    }
  }

  Future<File> writeItems(List<T> items) async {
    final file = await localFile;
    return file.writeAsString(
        jsonEncode(items, toEncodable: (object) => toJson(object as T)));
  }

  Future<T?> readItem() async {
    if (fromJson == null) return null;
    try {
      final file = await localFile;
      final contents = await file.readAsString();
      final dynamic jsons = json.decode(contents);
      print(jsons);
      return fromJson!(jsons);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<File> writeItem(T item) async {
    final file = await localFile;
    return file.writeAsString(
        jsonEncode(item, toEncodable: (object) => toJson(object as T)));
  }
}
