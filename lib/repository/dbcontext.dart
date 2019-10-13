import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbContext {
  static final DbContext _singleton = DbContext._internal();
  DbContext._internal();
  factory DbContext() {
    return _singleton;
  }

  Database messageDb;

  Future<void> copyDatabaseFromAssets(String dbName) async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, dbName);

    var indexOfDb = dbName.indexOf(".db") - 1;
    var version = int.parse(dbName.substring(indexOfDb, indexOfDb + 1));

    // delete existing if any
    await deletePreviewsVersions(version);
    //await File(path).delete();

    // Make sure the parent directory exists
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    ByteData data = await rootBundle.load(join("assets", "db", dbName));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(path).writeAsBytes(bytes, flush: true);

    // open the database
    messageDb = await openDatabase(path);
  }

  Future<void> deletePreviewsVersions(int actualVersion) async {
    var databasesPath = await getDatabasesPath();

    for (var i = 0; i <= actualVersion; i++) {
      String path;
      if (i == 0) {
        path = join(databasesPath, "messages.db");
      } else {
        path = join(databasesPath, "messages$i.db");
      }
      // delete existing if any
      if (await databaseExists(path)) await deleteDatabase(path);
    }
  }

  Future<void> initDB(String dbName) async {
    var pathDatabase = join(await getDatabasesPath(), dbName);
    var exists = await databaseExists(pathDatabase);

    if (exists) {
      print("Database exists, reading the database...");
      messageDb = await openDatabase(pathDatabase);
    } else {
      print("Coping the database...");
      await copyDatabaseFromAssets(dbName);
    }
    print("Ready!");
  }
}
